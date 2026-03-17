{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    
    # Use a nice colorscheme - feel free to change
    # Options: tokyonight, catppuccin, gruvbox, nord, dracula, onedark
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "night"; # storm, night, moon, or day
        transparent = false;
        terminal_colors = true;
      };
    };

    # Global options (like VSCode settings)
    opts = {
      # Line numbers
      number = true;
      relativenumber = true;
      
      # Tabs and indentation
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;
      smartindent = true;
      
      # Search
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      incsearch = true;
      
      # Appearance
      termguicolors = true;
      cursorline = true;
      signcolumn = "yes";
      scrolloff = 8;
      sidescrolloff = 8;
      
      # Behavior
      mouse = "a";
      clipboard = "unnamedplus"; # Use system clipboard
      undofile = true;
      swapfile = false;
      backup = false;
      
      # Splits
      splitright = true;
      splitbelow = true;
      
      # Completion
      completeopt = "menu,menuone,noselect";
      
      # Update time (for git signs, etc)
      updatetime = 250;
      timeoutlen = 300;
    };

    # Global mappings
    globals = {
      mapleader = " "; # Space as leader key
      maplocalleader = " ";
    };

    # Keymaps
    keymaps = [
      # Better window navigation
      { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options.desc = "Move to left window"; }
      { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options.desc = "Move to bottom window"; }
      { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options.desc = "Move to top window"; }
      { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options.desc = "Move to right window"; }
      
      # Resize windows
      { mode = "n"; key = "<C-Up>"; action = ":resize +2<CR>"; options.desc = "Increase window height"; }
      { mode = "n"; key = "<C-Down>"; action = ":resize -2<CR>"; options.desc = "Decrease window height"; }
      { mode = "n"; key = "<C-Left>"; action = ":vertical resize -2<CR>"; options.desc = "Decrease window width"; }
      { mode = "n"; key = "<C-Right>"; action = ":vertical resize +2<CR>"; options.desc = "Increase window width"; }
      
      # Buffer navigation
      { mode = "n"; key = "<S-h>"; action = ":bprevious<CR>"; options.desc = "Previous buffer"; }
      { mode = "n"; key = "<S-l>"; action = ":bnext<CR>"; options.desc = "Next buffer"; }
      { mode = "n"; key = "<leader>bd"; action = ":bdelete<CR>"; options.desc = "Delete buffer"; }
      
      # Clear search highlighting
      { mode = "n"; key = "<Esc>"; action = ":noh<CR>"; options.desc = "Clear search highlights"; }
      
      # Better indenting
      { mode = "v"; key = "<"; action = "<gv"; options.desc = "Indent left"; }
      { mode = "v"; key = ">"; action = ">gv"; options.desc = "Indent right"; }
      
      # Move text up and down
      { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; options.desc = "Move text down"; }
      { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; options.desc = "Move text up"; }
      
      # Keep cursor centered when scrolling
      { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; options.desc = "Scroll down"; }
      { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; options.desc = "Scroll up"; }
      { mode = "n"; key = "n"; action = "nzzzv"; options.desc = "Next search result"; }
      { mode = "n"; key = "N"; action = "Nzzzv"; options.desc = "Previous search result"; }
      
      # Save file
      { mode = "n"; key = "<C-s>"; action = ":w<CR>"; options.desc = "Save file"; }
      { mode = "i"; key = "<C-s>"; action = "<Esc>:w<CR>a"; options.desc = "Save file"; }
      
      # Quit
      { mode = "n"; key = "<leader>q"; action = ":q<CR>"; options.desc = "Quit"; }
      { mode = "n"; key = "<leader>Q"; action = ":qa<CR>"; options.desc = "Quit all"; }
      
      # Toggle file tree
      { mode = "n"; key = "<leader>e"; action = ":Neotree toggle<CR>"; options.desc = "Toggle file tree"; }
      
      # Telescope (fuzzy finder)
      { mode = "n"; key = "<leader><leader>"; action = ":Telescope find_files<CR>"; options.desc = "Find files"; }
      { mode = "n"; key = "<leader>ff"; action = ":Telescope find_files<CR>"; options.desc = "Find files"; }
      { mode = "n"; key = "<leader>fg"; action = ":Telescope live_grep<CR>"; options.desc = "Live grep"; }
      { mode = "n"; key = "<leader>fb"; action = ":Telescope buffers<CR>"; options.desc = "Find buffers"; }
      { mode = "n"; key = "<leader>fh"; action = ":Telescope help_tags<CR>"; options.desc = "Help tags"; }
      { mode = "n"; key = "<leader>fr"; action = ":Telescope oldfiles<CR>"; options.desc = "Recent files"; }
      { mode = "n"; key = "<leader>fs"; action = ":Telescope lsp_document_symbols<CR>"; options.desc = "Document symbols"; }
      { mode = "n"; key = "<leader>fc"; action = ":Telescope commands<CR>"; options.desc = "Commands"; }
      
      # LSP
      { mode = "n"; key = "gd"; action = ":lua vim.lsp.buf.definition()<CR>"; options.desc = "Go to definition"; }
      { mode = "n"; key = "gD"; action = ":lua vim.lsp.buf.declaration()<CR>"; options.desc = "Go to declaration"; }
      { mode = "n"; key = "gi"; action = ":lua vim.lsp.buf.implementation()<CR>"; options.desc = "Go to implementation"; }
      { mode = "n"; key = "gr"; action = ":Telescope lsp_references<CR>"; options.desc = "Find references"; }
      { mode = "n"; key = "K"; action = ":lua vim.lsp.buf.hover()<CR>"; options.desc = "Hover documentation"; }
      { mode = "n"; key = "<C-k>"; action = ":lua vim.lsp.buf.signature_help()<CR>"; options.desc = "Signature help"; }
      { mode = "n"; key = "<leader>rn"; action = ":lua vim.lsp.buf.rename()<CR>"; options.desc = "Rename symbol"; }
      { mode = "n"; key = "<leader>ca"; action = ":lua vim.lsp.buf.code_action()<CR>"; options.desc = "Code action"; }
      { mode = "v"; key = "<leader>ca"; action = ":lua vim.lsp.buf.code_action()<CR>"; options.desc = "Code action"; }
      { mode = "n"; key = "<leader>cf"; action = ":lua vim.lsp.buf.format({ async = true })<CR>"; options.desc = "Format file"; }
      { mode = "n"; key = "[d"; action = ":lua vim.diagnostic.goto_prev()<CR>"; options.desc = "Previous diagnostic"; }
      { mode = "n"; key = "]d"; action = ":lua vim.diagnostic.goto_next()<CR>"; options.desc = "Next diagnostic"; }
      { mode = "n"; key = "<leader>d"; action = ":lua vim.diagnostic.open_float()<CR>"; options.desc = "Show diagnostic"; }
      
      # Git
      { mode = "n"; key = "<leader>gg"; action = ":LazyGit<CR>"; options.desc = "LazyGit"; }
      { mode = "n"; key = "<leader>gb"; action = ":Gitsigns blame_line<CR>"; options.desc = "Git blame line"; }
      { mode = "n"; key = "<leader>gp"; action = ":Gitsigns preview_hunk<CR>"; options.desc = "Preview hunk"; }
      { mode = "n"; key = "<leader>gr"; action = ":Gitsigns reset_hunk<CR>"; options.desc = "Reset hunk"; }
      { mode = "n"; key = "<leader>gs"; action = ":Gitsigns stage_hunk<CR>"; options.desc = "Stage hunk"; }
      { mode = "n"; key = "<leader>gu"; action = ":Gitsigns undo_stage_hunk<CR>"; options.desc = "Undo stage hunk"; }
      
      # Terminal
      { mode = "n"; key = "<leader>t"; action = ":ToggleTerm<CR>"; options.desc = "Toggle terminal"; }
      { mode = "t"; key = "<Esc>"; action = "<C-\\><C-n>"; options.desc = "Exit terminal mode"; }
    ];

    plugins = {
      # File tree
      neo-tree = {
        enable = true;
        enable_diagnostics = true;
        enable_git_status = true;
        enable_modified_markers = true;
        enable_refresh_on_write = true;
        close_if_last_window = true;
        settings = {
          window = {
            width = 30;
            auto_expand_width = false;
          };
        };
        filesystem = {
          follow_current_file = {
            enabled = true;
          };
          use_libuv_file_watcher = true;
        };
      };

      # Fuzzy finder
      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
          };
        };
        settings = {
          defaults = {
            mappings = {
              i = {
                "<C-j>" = {
                  __raw = "require('telescope.actions').move_selection_next";
                };
                "<C-k>" = {
                  __raw = "require('telescope.actions').move_selection_previous";
                };
              };
            };
          };
        };
      };

      # Treesitter for syntax highlighting
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
          indent = {
            enable = true;
          };
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<C-space>";
              node_incremental = "<C-space>";
              scope_incremental = false;
              node_decremental = "<bs>";
            };
          };
        };
      };

      # LSP Configuration
      lsp = {
        enable = true;
        
        servers = {
          # Nix
          nil_ls = {
            enable = true;
            settings = {
              formatting = {
                command = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ];
              };
            };
          };
          
          # Python
          pyright = {
            enable = true;
          };
          
          ruff = {
            enable = true;
          };
          
          # You can add more LSP servers here as needed
          # bashls.enable = true;
          # tsserver.enable = true;
          # rust-analyzer.enable = true;
        };
        
        keymaps = {
          silent = true;
          lspBuf = {
            gd = "definition";
            gD = "declaration";
            K = "hover";
            gi = "implementation";
            "<C-k>" = "signature_help";
          };
          diagnostic = {
            "[d" = "goto_prev";
            "]d" = "goto_next";
          };
        };
      };

      # Autocompletion
      cmp = {
        enable = true;
        autoEnableSources = true;
        
        settings = {
          snippet = {
            expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
          };
          
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  else
                    fallback()
                  end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  else
                    fallback()
                  end
                end, { 'i', 's' }),
              })
            '';
          };
          
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
        };
      };

      # Snippet engine
      luasnip = {
        enable = true;
      };
      
      # For Copilot 
      copilot-lua = {
        enable = true;
        suggestion = {
          enabled = true;
          autoTrigger = true;
          keymap = {
            accept = "<Tab>";
            next = "<M-]>";
            prev = "<M-[>";
            dismiss = "<C-]>";
          };
        };
        panel = {
          enabled = true;
        };
      };

      # Status line
      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "auto";
            globalstatus = true;
            component_separators = {
              left = "|";
              right = "|";
            };
            section_separators = {
              left = "";
              right = "";
            };
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "branch" "diff" "diagnostics" ];
            lualine_c = [ "filename" ];
            lualine_x = [ "encoding" "fileformat" "filetype" ];
            lualine_y = [ "progress" ];
            lualine_z = [ "location" ];
          };
        };
      };

      # Buffer line (tabs)
      bufferline = {
        enable = true;
      };

      # Git signs (like VSCode git gutter)
      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = false; # Set to true if you want inline blame
          current_line_blame_opts = {
            delay = 300;
          };
          signs = {
            add = { text = "▎"; };
            change = { text = "▎"; };
            delete = { text = ""; };
            topdelete = { text = ""; };
            changedelete = { text = "▎"; };
          };
        };
      };

      # LazyGit integration
      lazygit = {
        enable = true;
      };

      # Terminal
      toggleterm = {
        enable = true;
        settings = {
          direction = "horizontal";
          size = 15;
          open_mapping = "[[<C-\\>]]";
        };
      };

      # Autopairs (auto-close brackets, quotes, etc)
      nvim-autopairs = {
        enable = true;
      };

      # Comment toggling
      comment = {
        enable = true;
      };

      # Indent guides
      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            enabled = true;
          };
        };
      };

      # Which-key (shows available keybindings)
      which-key = {
        enable = true;
        settings = {
          delay = 500;
        };
      };

      # Better notifications
      notify = {
        enable = true;
      };

      # Web dev icons
      web-devicons = {
        enable = true;
      };

      # Better UI for vim.ui.select and vim.ui.input
      dressing = {
        enable = true;
      };

      # Trouble (better diagnostics list)
      trouble = {
        enable = true;
      };

      # TODO comments highlighting
      todo-comments = {
        enable = true;
      };
    };

    # Extra plugins not in nixvim (add if needed)
    extraPlugins = with pkgs.vimPlugins; [
      # Add any additional plugins here
      vim-nix  # Extra Nix support
    ];

    # Extra Lua configuration
    extraConfigLua = ''
      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',
          header = "",
          prefix = "",
        },
      })
      
      -- Sign column icons
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    '';
  };
}
