" dein
if &compatible
  set nocompatible
endif
set runtimepath+=/home/naokihori/.vim/bundles/repos/github.com/Shougo/dein.vim
if dein#load_state('/home/naokihori/.vim/bundles/')
  call dein#begin('/home/naokihori/.vim/bundles')
  call dein#add('/home/naokihori/.vim/bundles/repos/github.com/Shougo/dein.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#end()
  if dein#check_install()
    call dein#install()
  endif
  call dein#save_state()
endif
nnoremap <Space>n :NERDTree<CR>

" file
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
autocmd BufWritePre * :%s/\s\+$//ge

" visual
syntax enable
set number
set cursorline
set showmatch
set virtualedit=onemore
set visualbell

" color
hi Comment ctermfg=34
hi Visual ctermbg=245
hi LineNr cterm=bold, ctermfg=196
hi CursorLineNr ctermfg=196, ctermbg=58
hi Pmenu ctermbg=55

" tab, indent
set expandtab
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
filetype plugin indent on

" cursor movement
set scrolloff=3
nnoremap j gj
nnoremap k gk
nnoremap Y y$

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

" html edit
augroup html
  autocmd!
  autocmd FileType html inoremap <buffer> </ </<C-x><C-o>
augroup END

