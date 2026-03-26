vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

local ok_telescope, telescope = pcall(require, "telescope")
if ok_telescope then
	telescope.setup({})
end

local ok_gitsigns, gitsigns = pcall(require, "gitsigns")
if ok_gitsigns then
	gitsigns.setup({})
end

local ok_lualine, lualine = pcall(require, "lualine")
if ok_lualine then
	lualine.setup({
		options = {
			theme = "auto",
			globalstatus = true,
		},
	})
end

local ok_which_key, which_key = pcall(require, "which-key")
if ok_which_key then
	which_key.setup({})
end

local ok_alpha, alpha = pcall(require, "alpha")
if ok_alpha then
	local dashboard = require("alpha.themes.dashboard")

	dashboard.section.header.val = {
		"███╗   ██╗██╗   ██╗██╗███╗   ███╗",
		"████╗  ██║██║   ██║██║████╗ ████║",
		"██╔██╗ ██║██║   ██║██║██╔████╔██║",
		"██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
		"██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
		"╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
	}

	dashboard.section.buttons.val = {
		dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
		dashboard.button("f", "󰱼  Find file", ":Telescope find_files<CR>"),
		dashboard.button("r", "  Recent", ":browse oldfiles<CR>"),
		dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
	}

	alpha.setup(dashboard.opts)
end

vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Write buffer" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
