vim.loader.enable()

vim.g.mapleader      = " "
vim.g.maplocalleader = " "

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.termguicolors  = true
vim.opt.clipboard      = "unnamedplus"
vim.opt.autoread       = true  -- required by opencode.nvim for buffer reloading
vim.opt.shiftwidth  = 2
vim.opt.tabstop     = 2
vim.opt.expandtab   = true  -- spaces instead of tabs

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
    options  = { theme = "auto", globalstatus = true },
    sections = {
      lualine_z = {
        { require("opencode").statusline },
      },
    },
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

-- opencode.nvim — replaces aider.nvim
local opencode_ok, opencode = pcall(require, "opencode")
if opencode_ok then
  vim.g.opencode_opts = {
    -- provider defaults to terminal; override here if needed
  }
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
  vim.keymap.set({ "n", "t" }, "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left pane" })
  vim.keymap.set({ "n", "t" }, "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to pane below" })
  vim.keymap.set({ "n", "t" }, "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to pane above" })
  vim.keymap.set({ "n", "t" }, "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right pane" })
end

map("<leader>w",  "<cmd>write<CR>",          "Write buffer")
map("<leader>e",  "<cmd>NvimTreeToggle<CR>",  "Toggle file tree")
map("<leader>ff", "<cmd>FzfLuaFindFiles<CR>", "Find files")
map("<leader>fg", "<cmd>FzfLuaLiveGrep<CR>",  "Live grep")

-- opencode.nvim keymaps
if opencode_ok then
  vim.keymap.set({ "n", "x" }, "<leader>Ao", function() require("opencode").toggle() end,   { desc = "Toggle opencode" })
  vim.keymap.set({ "n", "x" }, "<leader>Aa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
  vim.keymap.set({ "n", "x" }, "<leader>As", function() require("opencode").select() end,   { desc = "Select opencode action" })

  vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
  vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode",  expr = true })

  vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
  vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })
end
