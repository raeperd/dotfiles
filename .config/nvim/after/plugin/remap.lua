vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>ex', vim.cmd.Ex, { desc = 'Show [E][P]lorer' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected down with [J]' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected up with [K]' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Keep cursor after [J]' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Keep cursor in middle after [C-d]' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Keep cursor in middle after [C-u]' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Keep cursor in the middle after [n]' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Keep cursor in the middle after [N]' })

-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Keep buffer after [P]' })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[Y] with system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = '[Y] with system clipboard' })

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = '[Y] with system clipboard' })

-- This is going to get me cancelled
vim.keymap.set('i', '<C-c>', '<Esc>', { desc = '' })

vim.keymap.set('n', 'Q', '<nop>', { desc = '' })
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = 'Switch to last active tmux session' })
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = '[F]ormat current buffer' })

vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = '' })
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = '' })

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '' })
