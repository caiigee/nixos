{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		extraLuaConfig = /*lua*/ ''
      -- Fold settings
      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.o.foldenable = true
    	vim.o.foldlevel = 99
    	vim.o.foldcolumn = '1'

      -- Persistent folds
      local remember_folds = vim.api.nvim_create_augroup("remember_folds", { clear = true })
      vim.api.nvim_create_autocmd("BufWinLeave", {
        group = remember_folds,
        pattern = "?*",
        callback = function()
          vim.cmd("mkview")
        end,
      })
      vim.api.nvim_create_autocmd('BufWinEnter', {
        group = remember_folds,
        pattern = '?*',
        callback = function()
          vim.cmd('normal! zX')
          vim.cmd('silent! loadview')
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

    	-- Clipboard settings
    	vim.o.clipboard = 'unnamedplus'
			vim.o.number = true
			
			-- Misc settings
			vim.o.termguicolors = true
			vim.g.mapleader = ' '
			vim.g.maplocalleader = ' '
			vim.o.wrap = false
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Misc shortcuts
      vim.keymap.set('n', '<leader>x', ':w<CR>:bd<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>q', ':bd<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader><Tab>", "<cmd>bnext<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader><S-Tab>", "<cmd>bprevious<CR>", { noremap = true, silent = true })

			-- Moving lines Shortcuts
      vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
			vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
			vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
      vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
  	'';
    plugins = with pkgs.vimPlugins; [
			nvim-web-devicons
			vim-visual-multi
      plenary-nvim
      nui-nvim
      nvim-notify

			# Treesitter
      (nvim-treesitter.withPlugins (p: [
				p.tree-sitter-nix
				p.tree-sitter-rust
				p.tree-sitter-python
				p.tree-sitter-json
				p.tree-sitter-regex
				p.tree-sitter-bash
        p.tree-sitter-lua
			]))
			nvim-treesitter-textobjects

			# Telescope
			{
        plugin = telescope-nvim;
				type = "lua";
				config = ''
          require('telescope').setup()
          vim.keymap.set('n', '<leader>tf', '<cmd>Telescope find_files<cr>')
          vim.keymap.set('n', '<leader>tg', '<cmd>Telescope live_grep<cr>')
          vim.keymap.set('n', '<leader>tb', '<cmd>Telescope buffers<cr>')
          vim.keymap.set('n', '<leader>th', '<cmd>Telescope help_tags<cr>')
        '';
			}
      
      # LSP
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
         local lspconfig = require("lspconfig")

         lspconfig.nixd.setup({})
         lspconfig.taplo.setup({})
         lspconfig.rust_analyzer.setup({})
         lspconfig.pyright.setup({})
         lspconfig.marksman.setup({})

         local opts = { noremap = true, silent = true }
         vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
         vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
         vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
         vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
         vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        '';
      }

      # Formatters
      {
        plugin = conform-nvim;
        type = "lua";
        config = ''
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
          })
          
          vim.keymap.set("n", "<leader>f", function()
            conform.format({ async = true })
          end, { noremap = true, silent = true })
        '';
      }
      
      # Autocompletion
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require("cmp")
          cmp.setup({
            mapping = {
              ["<Tab>"] = cmp.mapping.select_next_item(),
              ["<S-Tab>"] = cmp.mapping.select_prev_item(),
              ["<CR>"] = cmp.mapping.confirm({ select = true }),
            },
            sources = {
              { name = "nvim_lsp" },
            }
          })
        '';
      }
      
      # Autopairs
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          local npairs = require('nvim-autopairs')
          npairs.setup({})

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
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup({
           sort = {
             sorter = "case_sensitive",
           },
           view = {
             width = 30,
           },
           renderer = {
             group_empty = true,
           },
           filters = {
             dotfiles = true,
           },
         })
         
         vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
        '';
      }

      # Comments
      {
        plugin = comment-nvim;
        type = "lua";
        config = "require('Comment').setup()";
      }

      # Surround
      {
        plugin = nvim-surround;
        type = "lua";
        config = "require('nvim-surround').setup()";
      }

      # Noice
      {
        plugin = noice-nvim;
        type = "lua";
        config = ''
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

      # IncRename
      {
        plugin = inc-rename-nvim;
        type = "lua";
        config = ''
          require("inc_rename").setup({})
          vim.keymap.set("n", "<leader>rn", function()
            return ":IncRename " .. vim.fn.expand("<cword>")
          end, { expr = true })
        '';
      }
    ];
    extraPackages = with pkgs; [
      tree-sitter
      prettierd

      # LSP:
      nixd
      pyright
      rust-analyzer
      taplo
      marksman

      # Linters:
      clippy
      
			# Telescope:
			ripgrep
			fd
    ];
  };
}
