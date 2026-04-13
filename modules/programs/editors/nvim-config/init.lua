vim.loader.enable()

vim.g.mapleader      = " "
vim.g.maplocalleader = " "

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.termguicolors  = true
vim.opt.clipboard      = "unnamedplus"

local function try(module_name)
  local ok, mod = pcall(require, module_name)
  return ok and mod or nil
end

vim.lsp.config("nixd", {
  cmd          = { "nixd" },
  root_markers = { "flake.nix", ".git" },
  filetypes    = { "nix" },
  settings     = {
    nixd = { formatting = { command = { "nixfmt" } } },
  },
})
vim.lsp.enable("nixd")

local fzf_lua = try("fzf-lua")
if fzf_lua then fzf_lua.setup({}) end

vim.api.nvim_create_user_command("FzfLuaFindFiles", function()
  if fzf_lua then fzf_lua.files() end
end, {})

vim.api.nvim_create_user_command("FzfLuaLiveGrep", function()
  if fzf_lua then fzf_lua.live_grep() end
end, {})

local nvim_tree = try("nvim-tree")
if nvim_tree then
  nvim_tree.setup({
    on_attach = function(bufnr)
      local api  = require("nvim-tree.api")
      local opts = function(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set("n", "l", api.node.open.edit,             opts("Open"))
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close node"))
    end,
    view                = { width = 32, side = "left" },
    renderer            = { group_empty = true },
    update_focused_file = { enable = true },
    actions             = { open_file = { quit_on_open = true } },
  })
end

local gitsigns = try("gitsigns")
if gitsigns then gitsigns.setup({}) end

local lualine = try("lualine")
if lualine then
  lualine.setup({
    options = { theme = "auto", globalstatus = true },
  })
end

local which_key = try("which-key")
if which_key then which_key.setup({}) end

local bufferline = try("bufferline")
if bufferline then
  bufferline.setup({
    options = { separator_style = "slant" },
  })
end

local autopairs = try("nvim-autopairs")
if autopairs then autopairs.setup({ check_ts = false }) end

local comment = try("Comment")
if comment then comment.setup({}) end

local ibl = try("ibl")
if ibl then ibl.setup({}) end

local hardtime = try("hardtime")
if hardtime then
  hardtime.setup({
    disabled_filetypes = {
      "NvimTree", "alpha", "help", "checkhealth",
      "lazy", "mason", "qf", "terminal",
    },
  })
end

local aider = try("aider")
if aider then
  aider.setup({
    auto_manage_context = true,
    default_bindings    = true,
  })
end

local alpha = try("alpha")
if alpha then
  local dashboard = require("alpha.themes.dashboard")

  dashboard.section.header.val = {
    " ███▄    █  ▓█████ ▒█████   ██▒   █▓  ██▓ ███▄ ▄███▓",
    " ██ ▀█   █  ▓█   ▀▒██▒  ██▒▓██░   █▒▒▓██▒▓██▒▀█▀ ██▒",
    "▓██  ▀█ ██▒ ▒███  ▒██░  ██▒ ▓██  █▒░▒▒██▒▓██    ▓██░",
    "▓██▒  ▐▌██▒ ▒▓█  ▄▒██   ██░  ▒██ █░░░░██░▒██    ▒██ ",
    "▒██░   ▓██░▒░▒████░ ████▓▒░   ▒▀█░  ░░██░▒██▒   ░██▒",
    "░ ▒░   ▒ ▒ ░░░ ▒░ ░ ▒░▒░▒░    ░ ▐░   ░▓  ░ ▒░   ░  ░",
    "░ ░░   ░ ▒░░ ░ ░    ░ ▒ ▒░    ░ ░░  ░ ▒ ░░  ░      ░",
    "   ░   ░ ░     ░  ░ ░ ░ ▒        ░  ░ ▒ ░░      ░   ",
    "         ░ ░   ░      ░ ░        ░    ░         ░   ",
    "",
    "              editor  ·  ai  ·  terminal              ",
  }

  dashboard.section.header.opts = { hl = "Keyword", position = "center" }

  dashboard.section.buttons.val = {
    dashboard.button("e", "New file",  ":ene <BAR> startinsert<CR>"),
    dashboard.button("f", "Find file", "<cmd>FzfLuaFindFiles<CR>"),
    dashboard.button("g", "Live grep", "<cmd>FzfLuaLiveGrep<CR>"),
    dashboard.button("r", "Recent",    ":browse oldfiles<CR>"),
    dashboard.button("q", "Quit",      ":qa<CR>"),
  }

  dashboard.section.footer.val = ""

  dashboard.opts.layout = {
    { type = "padding", val = 4 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
  }

  alpha.setup(dashboard.opts)
end

local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

map("<leader>w",  "<cmd>write<CR>",              "Write buffer")
map("<leader>e",  "<cmd>NvimTreeToggle<CR>",      "Toggle file tree")
map("<leader>ff", "<cmd>FzfLuaFindFiles<CR>",     "Find files")
map("<leader>fg", "<cmd>FzfLuaLiveGrep<CR>",      "Live grep")
map("<leader>Ao", "<cmd>AiderOpen<CR>",            "Open Aider")
map("<leader>Am", "<cmd>AiderAddModifiedFiles<CR>","Aider add modified files")