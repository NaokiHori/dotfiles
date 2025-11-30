local map = vim.keymap.set

-- Set Leader Key
vim.g.mapleader = ' '

-- Navigation
map('n', 'j', 'gj', { desc = 'Move down visually' })
map('n', 'k', 'gk', { desc = 'Move up visually' })
map('n', 'Y', 'y$', { desc = 'Yank till end of line' })
map('n', '<S-h>', '^', { desc = 'Move to first non-blank character' })
map('n', '<S-l>', '$l', { desc = 'Move to end of line' })
map('n', '<CR>', 'A<CR><ESC>', { desc = 'New line after current' })

-- Window/Split Management
map('n', 'sh', '<C-w>h', { desc = 'Move to left window' })
map('n', 'sj', '<C-w>j', { desc = 'Move to lower window' })
map('n', 'sk', '<C-w>k', { desc = 'Move to upper window' })
map('n', 'sl', '<C-w>l', { desc = 'Move to right window' })

-- Increment/Decrement
map('n', '+', '<C-a>', { desc = 'Increment number' })
map('n', '-', '<C-x>', { desc = 'Decrement number' })

-- Clean Search Highlights
map('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', { desc = 'Clear search highlights' })

-- Unmap / No-Op
map('n', 's', '<Nop>', { silent = true })
map('n', 'Q', '<Nop>', { silent = true })

-- Substitutions
map('n', '<Leader>O', ':%s/', { desc = 'Substitute entire file' })
