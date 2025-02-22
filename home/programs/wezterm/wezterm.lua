
-- Pull in stuff
local wezterm = require 'wezterm'
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- apply themes
config.color_scheme = 'Catppuccin Frappé (Gogh)'
bar.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
