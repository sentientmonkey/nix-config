vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.api.nvim_set_keymap('n', '<leader>t', ':TestNearest<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>T', ':TestFile<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>a', ':TestSuite<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>l', ':TestLast<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>g', ':TestVisit<cr>', {})

vim.api.nvim_set_keymap('n', '<leader>m', ':w!\\|:!make %<cr>', {})

vim.api.nvim_set_keymap('n', '<C-h>', ':NvimTreeToggle<cr>', {noremap = true})
