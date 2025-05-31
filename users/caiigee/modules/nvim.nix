{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = # lua
      ''
        -- Fold settings
        vim.o.foldmethod = 'expr'
        vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
        vim.o.foldenable = true
        vim.o.foldlevel = 99
        vim.o.foldcolumn = '1'
        local remember_folds = vim.api.nvim_create_augroup("remember_folds", { clear = true })
        vim.api.nvim_create_autocmd("BufWinLeave", {
          group = remember_folds,
          pattern = "?*",
          callback = function()
            vim.cmd("mkview")
          end,
        })
        vim.api.nvim_create_autocmd("BufWinEnter", {
          group = remember_folds,
          pattern = "?*",
          callback = function()
            vim.cmd("normal! zX")
            vim.cmd("silent! loadview")
          end,
        })

        -- Indentation settings
        vim.o.shiftwidth = 2
        vim.o.tabstop = 2
        vim.o.expandtab = true
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "rust", "python" },
          callback = function()
            vim.bo.shiftwidth = 4
            vim.bo.tabstop = 4
          end,
        })
        -- For some reason markdown is still 4 so I have to force it like this:
        vim.api.nvim_create_autocmd("FileType", {
          pattern = {"markdown"},
          callback = function()
            vim.bo.shiftwidth = 2
            vim.bo.tabstop = 2
          end,
        })

        -- Clipboard settings
        vim.o.clipboard = 'unnamedplus'
        vim.o.number = true

        -- Misc settings
        vim.o.termguicolors = true
        vim.g.mapleader = ' '
        vim.g.maplocalleader = ' '

        -- Text wrapping
        vim.o.wrap = false
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "markdown",
          callback = function()
            -- Enable line wrapping
            vim.opt_local.wrap = true
            -- Make it wrap at word boundaries
            vim.opt_local.linebreak = true
            -- Indents wrapped lines to match the beginning of the text
            vim.opt_local.breakindent = true
          end
        })

        -- Search settings
        vim.opt.ignorecase = true
        vim.opt.smartcase = true

        -- Misc shortcuts
        vim.keymap.set('n', '<leader>x', ':w<CR>:bd<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>X', ':w<CR>:bd<CR>:q<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>q', ':bd<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>Q', ':bd<CR>:q<CR>', { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader><Tab>", "<cmd>bnext<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader><S-Tab>", "<cmd>bprevious<CR>", { noremap = true, silent = true })

        -- Moving lines Shortcuts
        vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
        vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
        vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
        vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })

        -- Disable arrow keys in Normal mode
        vim.keymap.set('n', '<Up>', '<Nop>', { noremap = true })
        vim.keymap.set('n', '<Down>', '<Nop>', { noremap = true })
        vim.keymap.set('n', '<Left>', '<Nop>', { noremap = true })
        vim.keymap.set('n', '<Right>', '<Nop>', { noremap = true })

        -- Disable arrow keys in Insert mode
        vim.keymap.set('i', '<Up>', '<Nop>', { noremap = true })
        vim.keymap.set('i', '<Down>', '<Nop>', { noremap = true })
        vim.keymap.set('i', '<Left>', '<Nop>', { noremap = true })
        vim.keymap.set('i', '<Right>', '<Nop>', { noremap = true })

        -- Disable arrow keys in Visual mode
        vim.keymap.set('v', '<Up>', '<Nop>', { noremap = true })
        vim.keymap.set('v', '<Down>', '<Nop>', { noremap = true })
        vim.keymap.set('v', '<Left>', '<Nop>', { noremap = true })
        vim.keymap.set('v', '<Right>', '<Nop>', { noremap = true })
      '';
    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      vim-visual-multi
      plenary-nvim
      nui-nvim
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
      friendly-snippets
      comment-nvim

      # Catppuccin
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = # lua
          ''
            require("catppuccin").setup({
              flavour = "mocha",
              term_colors = true,
              transparent_background = false,
              integrations = {
                treesitter = true,
                native_lsp = {
                  enabled = true,
                  virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                  },
                  underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                  },
                },
              }
            })
            vim.cmd.colorscheme("catppuccin")
          '';
      }

      # Treesitter
      {
        plugin = (
          nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-query
            p.tree-sitter-rust
            p.tree-sitter-python
            p.tree-sitter-json
            p.tree-sitter-regex
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-markdown
            p.tree-sitter-markdown-inline
            p.tree-sitter-latex
          ])
        );
        type = "lua";
        config = # lua
          ''
            require("nvim-treesitter.configs").setup {
              highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
              },
              indent = {
                enable = true
              }
            }
          '';
      }
      nvim-treesitter-textobjects

      # Telescope
      {
        plugin = telescope-nvim;
        type = "lua";
        config = # lua
          ''
              require('telescope').setup({
                pickers = {
                  find_files = {
                    hidden = true,
                  }
                }
              })
              vim.keymap.set('n', '<leader>tf', '<cmd>Telescope find_files<cr>')
              vim.keymap.set('n', '<leader>tg', '<cmd>Telescope live_grep<cr>')
              vim.keymap.set('n', '<leader>tb', '<cmd>Telescope buffers<cr>')
              vim.keymap.set('n', '<leader>th', '<cmd>Telescope help_tags<cr>')
              vim.keymap.set('n', '<leader>to', function()
                require("telescope.builtin").oldfiles({
                  cwd_only = true,
              })
            end)
          '';
      }

      # LSP
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = # lua
          ''
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.nixd.setup({
             capabilities = capabilities, 
            })
            lspconfig.taplo.setup({
             capabilities = capabilities, 
            })
            lspconfig.rust_analyzer.setup({
             capabilities = capabilities, 
            })
            lspconfig.pyright.setup({
             capabilities = capabilities, 
            })
            lspconfig.marksman.setup({
             capabilities = capabilities, 
            })

            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>se", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          '';
      }

      # Formatters
      {
        plugin = conform-nvim;
        type = "lua";
        config = # lua
          ''
            local conform = require("conform")
            conform.setup({
              formatters_by_ft = {
                nix = { "nixfmt" },
                toml = { "taplo" },
                rust = { "rustfmt" },
                python = { "black" },
                json = { "prettierd" },
                html = { "prettierd" },
                css = { "prettierd" },
                markdown = { "prettierd" },
              },
              format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
              },
            })

            vim.keymap.set("n", "<leader>f", function()
              conform.format({ async = true })
            end, { noremap = true, silent = true })
          '';
      }

      # Linters
      {
        plugin = nvim-lint;
        type = "lua";
        config = # lua
          ''
            local lint = require("lint")
            lint.linters_by_ft = {
              nix = { "statix" },
              python = { "ruff" },
              rust = { "clippy" },
              lua = { "selene" },
              json = { "spectral" },
              html = { "tidy" },
              css = { "stylelint" },
              bash = { "shellcheck" },
            }
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
              group = vim.api.nvim_create_augroup("lint", { clear = true }), 
              callback = function()
                lint.try_lint()
              end,
            })
          '';
      }

      # Autocompletion
      {
        plugin = nvim-cmp;
        type = "lua";
        config = # lua
          ''
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()
            cmp.setup({
              mapping = {
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
              },
              sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "luasnip" },
              },
              snippet = {
                expand = function(args)
                  require("luasnip").lsp_expand(args.body)
                end,
              },
            })
          '';
      }

      # Autopairs
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = # lua
          ''
            local npairs = require('nvim-autopairs')
            local Rule = require('nvim-autopairs.rule')
            local cond = require('nvim-autopairs.conds')
            npairs.setup({
              -- Read what this does in the README.md on gh
              enable_check_bracket_line = false
            })

            npairs.add_rules({
              Rule("|","|"):with_move(cond.done())
            })

            -- Autocomplete fuckery, no clue honestly...
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on(
              'confirm_done',
              cmp_autopairs.on_confirm_done()
            )
          '';
      }

      # File explorer
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = # lua
          ''
            vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
            require("neo-tree").setup({
              filesystem = {
                filtered_items = {
                  visible = true,
                  hide_dotfiles = false,
                  hide_gitignored = false,
                },
              },
            })
          '';
      }

      # Dashboard
      {
        plugin = dashboard-nvim;
        type = "lua";
        config = # lua
          ''
            local dashboard = require("dashboard")
            dashboard.setup({
              theme = 'doom',
              config = {
                header = {
                  '███╗   ██╗██╗   ██╗██╗███╗   ███╗',
                  '████╗  ██║██║   ██║██║████╗ ████║',
                  '██╔██╗ ██║██║   ██║██║██╔████╔██║',
                  '██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
                  '██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
                  '╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
                },
                center = {
                  {
                    icon = '🕒 ',
                    desc = 'Recent files',
                    action = function()
                      require("telescope.builtin").oldfiles({
                        cwd_only = true,
                      })
                    end,
                  },
                  {
                    icon = '🔍 ',
                    desc = 'Find files',
                    action = 'Telescope find_files',
                  },
                  {
                    icon = '🍇 ',
                    desc = 'Search in files',
                    action = 'Telescope live_grep',
                  },
                  {
                    icon = '📄 ',
                    desc = 'New file',
                    action = 'ene',
                  },
                },
              }
            })
          '';
      }

      # Lualine
      {
        plugin = lualine-nvim;
        type = "lua";
        config = # lua
          ''
            require("lualine").setup({
              sections = {
                lualine_x = {
                  {
                    require("noice").api.statusline.mode.get,
                    cond = require("noice").api.statusline.mode.has,
                    color = { fg = "#ff9e64" },
                  }
                },
              },
            })
          '';
      }

      # Otter
      {
        plugin = otter-nvim;
        type = "lua";
        config = # lua
          ''
            require("otter").activate({ "bash", "lua", "css", "python" }, true, true, nil)
          '';
      }

      # Noice
      {
        plugin = noice-nvim;
        type = "lua";
        config = # lua
          ''
            require("noice").setup({
              lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                  ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                  ["vim.lsp.util.stylize_markdown"] = true,
                  ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
              },
              presets = {
                inc_rename = true,
                lsp_doc_border = true,
                command_palette = true,
              },
            })
          '';
      }

      # Surround
      {
        plugin = nvim-surround;
        type = "lua";
        config = # lua
          ''
            require("nvim-surround").setup()
          '';
      }

      # IncRename
      {
        plugin = inc-rename-nvim;
        type = "lua";
        config = # lua
          ''
            require("inc_rename").setup({})
            vim.keymap.set("n", "<leader>rn", function()
              return ":IncRename " .. vim.fn.expand("<cword>")
            end, { expr = true })
          '';
      }
    ];
    extraPackages = with pkgs; [
      tree-sitter
      clang

      # Formatters
      prettierd
      nixfmt-rfc-style
      rustfmt
      black

      # LSP
      nixd
      pyright
      rust-analyzer
      taplo
      marksman

      # Linters
      clippy
      vale
      statix
      ruff
      selene
      html-tidy
      spectral-language-server
      stylelint
      shellcheck

      # Telescope
      ripgrep
      fd
    ];
  };
}
