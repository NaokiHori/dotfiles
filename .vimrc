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

filetype plugin indent on

call map(dein#check_clean(), "delete(v:val, 'rf')")

if dein#check_install()
  call dein#install()
endif

" file
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
autocmd BufWritePre * :%s/\s\+$//ge
set viminfo='20,\"1000

" tab, indent
set expandtab
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2

" visual
syntax enable
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
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap + <C-a>
nnoremap - <C-x>
set backspace=indent,eol,start

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

autocmd BufNewFile,BufRead *.tex set spell
autocmd BufNewFile,BufRead *.gp set syntax=gnuplot

