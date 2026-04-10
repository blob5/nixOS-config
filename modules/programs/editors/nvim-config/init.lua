vim.loader.enable()

vim.g.mapleader      = " "
vim.g.maplocalleader = " "

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.termguicolors  = true
vim.opt.clipboard      = "unnamedplus"

-- ─── Helpers ──────────────────────────────────────────────────────────────────

local function try(module_name)
  local ok, mod = pcall(require, module_name)
  return ok and mod or nil
end

-- ─── LSP: Copilot ─────────────────────────────────────────────────────────────

vim.lsp.config("copilot", {
  cmd                 = { "copilot-language-server", "--stdio" },
  root_markers        = { ".git" },
  single_file_support = true,
})
vim.lsp.enable("copilot")

-- ─── FFF ──────────────────────────────────────────────────────────────────────

local fff = try("fff")
if fff then
  fff.setup({})
end

vim.api.nvim_create_user_command("FFFFindFiles", function()
  if fff then fff.find_files() end
end, {})

vim.api.nvim_create_user_command("FFFLiveGrep", function()
  if fff then fff.live_grep() end
end, {})

-- ─── Nvim-tree ────────────────────────────────────────────────────────────────

local nvim_tree = try("nvim-tree")
if nvim_tree then
  nvim_tree.setup({
    on_attach = function(bufnr)
      local api  = require("nvim-tree.api")
      local opts = function(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set("n", "l", api.node.open.edit,            opts("Open"))
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close node"))
    end,
    view = {
      width = 32,
      side  = "left",
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

-- ─── Noice ─────────────────────────────────────────────────────────────────
local noice = try("noice")
if noice then
  noice.setup({
    cmdline = {
      view = "cmdline_popup",   -- floating centered popup
      format = {
        cmdline = { icon = ">" },
      },
    },
    messages = { enabled = true },
    popupmenu = { enabled = true },
    lsp = {
      -- noice can handle LSP progress/hover too, opt in as wanted
      progress = { enabled = false },
    },
  })
end

-- ─── Gitsigns ─────────────────────────────────────────────────────────────────

local gitsigns = try("gitsigns")
if gitsigns then gitsigns.setup({}) end

-- ─── Lualine ──────────────────────────────────────────────────────────────────

local lualine = try("lualine")
if lualine then
  lualine.setup({
    options = {
      theme        = "auto",
      globalstatus = true,
    },
  })
end

-- ─── Which-key ────────────────────────────────────────────────────────────────

local which_key = try("which-key")
if which_key then which_key.setup({}) end

-- ─── Bufferline ───────────────────────────────────────────────────────────────

local bufferline = try("bufferline")
if bufferline then
  bufferline.setup({
    options = {
      separator_style = "slant",
    },
  })
end

-- ─── Autopairs ────────────────────────────────────────────────────────────────

local autopairs = try("nvim-autopairs")
if autopairs then autopairs.setup({ check_ts = false }) end

-- ─── Comment.nvim  (gcc = line comment, gbc = block comment) ─────────────────

local comment = try("Comment")
if comment then comment.setup({}) end

-- ─── Indent-blankline ─────────────────────────────────────────────────────────

local ibl = try("ibl")
if ibl then ibl.setup({}) end

-- ─── Todo-comments ────────────────────────────────────────────────────────────

local todo = try("todo-comments")
if todo then todo.setup({}) end

-- ─── Hardtime ─────────────────────────────────────────────────────────────────

local hardtime = try("hardtime")
if hardtime then
  hardtime.setup({
    disabled_filetypes = {
      "NvimTree", "alpha", "help", "checkhealth",
      "lazy", "mason", "qf", "terminal",
    },
  })
end

-- ─── Sidekick ─────────────────────────────────────────────────────────────────

local sidekick = try("sidekick")
if sidekick then sidekick.setup({}) end

local function sk(method)
  return function()
    local cli = try("sidekick.cli")
    if cli then cli[method]() end
  end
end

vim.api.nvim_create_user_command("SidekickToggle",  sk("toggle"),  {})
vim.api.nvim_create_user_command("SidekickSelect",  sk("select"),  {})
vim.api.nvim_create_user_command("SidekickPrompt",  sk("prompt"),  {})
vim.api.nvim_create_user_command("SidekickClaude", function()
  local cli = try("sidekick.cli")
  if cli then cli.toggle({ name = "claude", focus = true }) end
end, {})

-- ─── Alpha dashboard ──────────────────────────────────────────────────────────

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

  dashboard.section.header.opts = {
    hl = "Keyword",
    position = "center",
  }

  dashboard.section.buttons.val = {
    dashboard.button("e", "New file",   ":ene <BAR> startinsert<CR>"),
    dashboard.button("f", "Find file", "<cmd>FFFFindFiles<CR>"),
    dashboard.button("g", "Live grep",  "<cmd>FFFLiveGrep<CR>"),
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

-- ─── Keymaps ──────────────────────────────────────────────────────────────────

local map = function(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { desc = desc })
end

map("<leader>w",  "<cmd>write<CR>",          "Write buffer")
map("<leader>e",  "<cmd>NvimTreeFocus<CR>",   "Focus file tree")
map("<leader>ff", "<cmd>FFFFindFiles<CR>",    "Find files")
map("<leader>fg", "<cmd>FFFLiveGrep<CR>",     "Live grep")
map("<leader>aa", "<cmd>SidekickToggle<CR>",  "Toggle Sidekick CLI")
map("<leader>as", "<cmd>SidekickSelect<CR>",  "Select Sidekick CLI")
map("<leader>ap", "<cmd>SidekickPrompt<CR>",  "Pick Sidekick prompt")
map("<leader>ac", "<cmd>SidekickClaude<CR>",  "Toggle Claude")
