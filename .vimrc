set encoding=utf-8
set ttyfast

if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml('~/.dein.toml')
  call dein#end()
  call dein#save_state()
endif
call map(dein#check_clean(), "delete(v:val, 'rf')")
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

" file
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
set viminfo='20,<1000,s1000

" Remove trailing spaces for all files
autocmd BufWritePre * :call RemoveCommentTrailingSpaces()
function! RemoveCommentTrailingSpaces() abort
  " Get the extension of the current file name
  let l:extension = expand('%:e')
  " 1. markdown: do nothing
  " 2. Rust: remove trailing spaces if the line is NOT rust doc
  " 3. Others: remove trailing spaces
  if 'md' != l:extension
    if 'rs' == l:extension
      " Define a regular expression to match Rust comments
      " 1. two slashes followed by an exclamation mark "//!"
      " 2. three slashes "///"
      let l:rustdoc_regex = '\(\/\/\/\|\/\/!\)'
      " save current cursor position
      let l:cursor_pos = getpos('.')
      " perform substitution
      execute ':v/' . l:rustdoc_regex . '/s/\s\+$//ge'
      " recover previous cursor position
      :call setpos('.', l:cursor_pos)
    else
      execute ':%s/\s\+$//ge'
    endif
  endif
endfunction

" tab, indent
set expandtab
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
autocmd Filetype rst setlocal expandtab tabstop=3 shiftwidth=3 softtabstop=3

" visual
syntax enable
colorscheme iceberg
set number
set laststatus=2
set showmatch
set virtualedit=onemore
set scrolloff=3

" key mapping
nnoremap j gj
nnoremap k gk
nnoremap Y y$
nnoremap <S-h> ^
nnoremap <S-l> $l
nnoremap <CR> A<CR><ESC>
nnoremap s <Nop>
nnoremap Q <Nop>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap + <C-a>
nnoremap - <C-x>
set backspace=indent,eol,start

set mouse=

" search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nnoremap <silent><Esc><Esc> :nohlsearch<CR><Esc>

" completion
set wildmenu

let g:indentLine_fileTypeExclude = ['tex']
let g:tex_flavor = "latex"

autocmd BufNewFile,BufRead *.gp  set syntax=gnuplot
autocmd BufNewFile,BufRead *.tex set syntax=plaintex
autocmd BufNewFile,BufRead *.tex set spell
autocmd BufNewFile,BufRead *.md  set spell
autocmd BufNewFile,BufRead *.txt set spell
autocmd BufNewFile,BufRead *.rst set spell
autocmd BufNewFile,BufRead COMMIT_EDITMSG set spell

let fortran_free_source=1

set ttimeout
set ttimeoutlen=50

" move the cursor to where it existed
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" do not warn compound literal
let c_no_curly_error=1

" run Rust formatter when saved
let g:rustfmt_autosave = 1
