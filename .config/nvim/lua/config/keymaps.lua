-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- VS Code integration (early return)
if vim.g.vscode then
  local vscode = require("vscode")
  
  -- Essential VS Code keymaps
  vim.keymap.set("n", "<leader><leader>", function() vscode.action("workbench.action.quickOpen") end)
  vim.keymap.set("n", "<leader>sf", function() vscode.action("find-it-faster.findFiles") end)
  vim.keymap.set("n", "<leader>sg", function() vscode.action("find-it-faster.findWithinFiles") end)
  vim.keymap.set("n", "<leader>ca", function() vscode.action("editor.action.codeAction") end)
  vim.keymap.set("n", "<leader>cr", function() vscode.action("editor.action.rename") end)
  vim.keymap.set("n", "<leader>gd", function() vscode.action("editor.action.revealDefinition") end)
  vim.keymap.set("n", "<leader>gr", function() vscode.action("editor.action.goToReferences") end)
  
  return -- Exit early, skip terminal keymaps
end

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d', { desc = "Delete to clipboard" })

local tmux = require("nvim-tmux-navigation")
vim.keymap.set("n", "<C-h>", tmux.NvimTmuxNavigateLeft)
vim.keymap.set("n", "<C-j>", tmux.NvimTmuxNavigateDown)
vim.keymap.set("n", "<C-l>", tmux.NvimTmuxNavigateRight)
vim.keymap.set("n", "<C-k>", tmux.NvimTmuxNavigateUp)
vim.keymap.set("n", "<C-\\>", tmux.NvimTmuxNavigateLastActive)
vim.keymap.set("n", "<C-Space>", tmux.NvimTmuxNavigateNext)

local git = require("gitsigns")
