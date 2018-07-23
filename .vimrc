" omajinai
if &compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein
let s:cache_home=empty($XDG_CACHE_HOME)?expand('~/.vim'):$XDG_CACHE_HOME
let s:dein_dir=s:cache_home.'/bundles'
let s:dein_repo_dir=s:dein_dir.'/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim'.shellescape(s:dein_repo_dir))
endif
let &runtimepath=s:dein_repo_dir.",".&runtimepath

let s:toml_file='~/.dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" file
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
autocmd BufWritePre * :%s/\s\+$//ge

" visual
syntax enable
set t_Co=256  " needed for tmux
set title
set number
set cursorline
set showmatch
set virtualedit=onemore
set visualbell

" tab, indent
set expandtab
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
filetype plugin indent on


" key mapping
set scrolloff=3
nnoremap j gj
nnoremap k gk
nnoremap Y y$
nnoremap <S-h> ^
nnoremap <S-l> $
nnoremap <CR> A<CR><ESC>
set backspace=indent,eol,start

" search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" replacement
set gdefault
set completeopt=menuone
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec "imap " . k . " " . k . "<C-N><C-P>"
endfor

" status line
set laststatus=2
" set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

