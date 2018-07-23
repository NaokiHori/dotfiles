" dein
if &compatible
  set nocompatible
endif
set runtimepath+=/home/naokihori/.vim/bundles/repos/github.com/Shougo/dein.vim
if dein#load_state('/home/naokihori/.vim/bundles/')
  call dein#begin('/home/naokihori/.vim/bundles')
  call dein#add('/home/naokihori/.vim/bundles/repos/github.com/Shougo/dein.vim')
  " tree
  call dein#add('scrooloose/nerdtree')
  " colorscheme
  call dein#add('tomasr/molokai')
  " block comment
  call dein#add('tpope/vim-commentary')
  " quick run
  call dein#add('thinca/vim-quickrun')
  call dein#end()
  if dein#check_install()
    call dein#install()
  endif
  call dein#save_state()
endif

" plug-in config
nnoremap <Space>n :NERDTree<CR>
nnoremap <Space>q :QuickRun<CR>
let g:quickrun_config = {
\  "_": {
\    "outputter/buffer/split": ":botright",
\    "outputter/buffer/close_on_empty": 1
\  }
\}

" file
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
autocmd BufWritePre * :%s/\s\+$//ge

" color
colorscheme molokai
set t_Co=256

" visual
syntax enable
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
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

