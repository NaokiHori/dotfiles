" omajinai
if &compatible
  set nocompatible
endif
filetype plugin indent on

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

"" dein
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
""

" file
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
autocmd BufWritePre * :%s/\s\+$//ge

" tab, indent
set expandtab
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2

" visual
syntax enable
set t_Co=256  " needed for tmux
set number
set cursorline
set showmatch
set virtualedit=onemore
set visualbell
set scrolloff=3

" key mapping
nnoremap j gj
nnoremap k gk
nnoremap Y y$
nnoremap <S-h> ^
nnoremap <S-l> $
nnoremap <CR> A<CR><ESC>
nnoremap s <Nop>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
set backspace=indent,eol,start

" search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

