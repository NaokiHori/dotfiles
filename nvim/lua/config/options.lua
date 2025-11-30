local opt = vim.opt

-- File/Editing
opt.encoding = 'utf-8'
opt.ttyfast = true
opt.shada = "h,'20,<1000,s1000"
opt.autoread = true
opt.hidden = true
opt.showcmd = true
opt.compatible = false
opt.mouse = ''
opt.backspace = 'indent,eol,start'

-- Tabs and Indentation
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Visual
opt.syntax = 'enable'
opt.number = true
opt.laststatus = 2
opt.showmatch = true
opt.virtualedit = 'onemore'
opt.scrolloff = 3

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.wrapscan = true
opt.hlsearch = true

-- Completion/Command Line
opt.wildmenu = true

-- Timeouts
opt.ttimeout = true
opt.ttimeoutlen = 50
