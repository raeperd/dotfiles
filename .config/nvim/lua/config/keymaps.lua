-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete to clipboard" })

local tmux = require("nvim-tmux-navigation")
vim.keymap.set("n", "<C-h>", tmux.NvimTmuxNavigateLeft)
vim.keymap.set("n", "<C-j>", tmux.NvimTmuxNavigateDown)
vim.keymap.set("n", "<C-l>", tmux.NvimTmuxNavigateRight)
vim.keymap.set("n", "<C-k>", tmux.NvimTmuxNavigateUp)
vim.keymap.set("n", "<C-\\>", tmux.NvimTmuxNavigateLastActive)
vim.keymap.set("n", "<C-Space>", tmux.NvimTmuxNavigateNext)

local git = require("gitsigns")
