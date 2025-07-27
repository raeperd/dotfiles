---@diagnostic disable: undefined-global
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Setting options ]]
-- See `:help vim.opt`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
vim.opt.clipboard = ""

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- System clipboard yanking
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Buffer navigation
vim.keymap.set("n", "[b", "<CMD>bprev<CR>", { desc = "Go to previous [B]uffer" })
vim.keymap.set("n", "]b", "<CMD>bnext<CR>", { desc = "Go to next [B]uffer" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
	local vscode = require("vscode")

	local navigation_mappings = {
		{ "]g", "workbench.action.editor.nextChange", "Go to next git change" },
		{ "[g", "workbench.action.editor.previousChange", "Go to previous git change" },
		{ "]d", "editor.action.marker.next", "Go to next diagnostic" },
		{ "[d", "editor.action.marker.prev", "Go to previous diagnostic" },
	}

	local buffer_mappings = {
		{ "<leader>,", "workbench.action.showAllEditors", "Show all editors" },
		{ "<leader>bd", "workbench.action.closeActiveEditor", "Close active editor" },
		{ "<leader>bo", "workbench.action.closeOtherEditors", "Close other editors" },
	}

	local code_mappings = {
		{ "<leader>ca", "editor.action.codeAction", "Code action" },
		{ "<leader>cr", "editor.action.rename", "Rename symbol" },
		{ "<leader>gd", "editor.action.revealDefinition", "Go to definition" },
		{ "<leader>gs", "workbench.action.gotoSymbol", "Go to symbol" },
		{ "<leader>gr", "editor.action.goToReferences", "Go to references" },
		{ "<leader>gm", "editor.action.goToImplementation", "Go to implementation" },
	}

	local search_mappings = {
		{ "<leader><leader>", "workbench.action.quickOpen", "Quick open" },
		{ "<leader>sg", "find-it-faster.findWithinFiles", "Find in files" },
		{ "<leader>sf", "find-it-faster.findFiles", "Find files" },
		{ "<leader>st", "find-it-faster.findFilesWithType", "Find files by type" },
		{ "<leader>ss", "workbench.action.showAllSymbols", "Show all symbols" },
	}

	local all_mappings = {
		navigation_mappings,
		buffer_mappings,
		code_mappings,
		search_mappings,
	}

	for _, group in ipairs(all_mappings) do
		for _, mapping in ipairs(group) do
			local keys, action, desc = mapping[1], mapping[2], mapping[3]
			vim.keymap.set({ "n", "v" }, keys, function()
				vscode.action(action)
			end, { desc = desc })
		end
	end
end

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins_always" },
		{ import = "plugins_notvscode", cond = not vim.g.vscode },
	},
	-- automatically check for plugin updates
	checker = { enabled = true },
})
