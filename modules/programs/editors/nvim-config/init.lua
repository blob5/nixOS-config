vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- Telescope
local ok_telescope, telescope = pcall(require, "telescope")
if ok_telescope then
    telescope.setup({})
end

-- Nvim-tree
local ok_nvim_tree, nvim_tree = pcall(require, "nvim-tree")

local function nvim_tree_on_attach(bufnr)
    local api = require("nvim-tree.api")
    api.config.mappings.default_on_attach(bufnr)
    local opts = function(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    vim.keymap.set("n", "l", api.node.open.edit,  opts("Open"))
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close node"))
end

if ok_nvim_tree then
    nvim_tree.setup({
        on_attach = nvim_tree_on_attach,
        view = {
            width = 32,
            side = "left",
        },
        renderer = {
            group_empty = true,
        },
        update_focused_file = {
            enable = true,
        },
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
    })
end

-- Gitsigns
local ok_gitsigns, gitsigns = pcall(require, "gitsigns")
if ok_gitsigns then
    gitsigns.setup({})
end

-- Lualine
local ok_lualine, lualine = pcall(require, "lualine")
if ok_lualine then
    lualine.setup({
        options = {
            theme = "auto",
            globalstatus = true,
        },
    })
end

-- Which-key
local ok_which_key, which_key = pcall(require, "which-key")
if ok_which_key then
    which_key.setup({})
end

-- Bufferline
local ok_bufferline, bufferline = pcall(require, "bufferline")
if ok_bufferline then
    bufferline.setup({
        options = {
            separator_style = "slant",
        },
    })
end

-- Autopairs
local ok_autopairs, autopairs = pcall(require, "nvim-autopairs")
if ok_autopairs then
    autopairs.setup({
        check_ts = false,
    })
end

-- Comment.nvim (gcc = line comment, gbc = block comment)
local ok_comment, comment = pcall(require, "Comment")
if ok_comment then
    comment.setup({})
end

-- Indent-blankline
local ok_ibl, ibl = pcall(require, "ibl")
if ok_ibl then
    ibl.setup({})
end

-- Todo-comments
local ok_todo, todo = pcall(require, "todo-comments")
if ok_todo then
    todo.setup({})
end

-- Alpha dashboard
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
        dashboard.button("e", "  New file",    ":ene <BAR> startinsert<CR>"),
        dashboard.button("f", "󰱼  Find file",  ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent",     ":browse oldfiles<CR>"),
        dashboard.button("q", "󰅚  Quit",       ":qa<CR>"),
    }
    alpha.setup(dashboard.opts)
end

-- Keymaps
vim.keymap.set("n", "<leader>w",  "<cmd>write<CR>",                { desc = "Write buffer" })
vim.keymap.set("n", "<leader>e",  "<cmd>NvimTreeFocus<CR>",         { desc = "Focus file tree" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>",  { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",   { desc = "Live grep" })
