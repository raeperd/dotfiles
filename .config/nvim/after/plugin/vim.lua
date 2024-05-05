vim.opt.relativenumber = true

vim.opt.clipboard = ''

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank text to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d', { desc = 'Delete and Yank text to clipboard' })
