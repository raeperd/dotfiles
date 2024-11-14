-- Referenced https://www.josean.com/posts/how-to-setup-wezterm-terminal
local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.default_prog = { "/bin/zsh", "-l", "-c", "source ~/.zshrc; tmux attach || tmux" }

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19
config.color_scheme = "Catppuccin Mocha" -- Mocha, Macchiato, Frappe, Latte

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.macos_window_background_blur = 10
config.max_fps = 144

config.window_padding = {
	top = 35,
	bottom = 20,
	left = 40,
}

return config
