{ pkgs, ... }:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n";
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		extraLuaConfig = ''
      -- Fold settings
      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.o.foldenable = true
    	vim.o.foldlevel = 99
    	vim.o.foldcolumn = '1'

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
			
			-- Autocommands
			vim.api.nvim_create_autocmd("InsertEnter", {
					pattern = "*",
					command = "set nohlsearch"
			})

			-- Moving lines Shortcuts
			vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
			vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
			vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
			vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
			vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
			vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

      -- Telescope Shortcuts
      vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
      vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
      vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
  	'';
    plugins = with pkgs.vimPlugins; [
			nvim-web-devicons
			vim-visual-multi
			nvim-spectre
			nvim-surround

			# Treesitter
      (nvim-treesitter.withPlugins (p: [
				p.tree-sitter-nix
				p.tree-sitter-rust
				p.tree-sitter-python
				p.tree-sitter-json
			]))
			nvim-treesitter-textobjects

			# Telescope
			{
        plugin = telescope-nvim;
				type = "lua";
				config = "require(\"telescope\").setup()";
			}
      plenary-nvim
      
      # LSP
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local lspconfig = require("lspconfig")

          lspconfig.nixd.setup({})
          lspconfig.pyright.setup({})
          lspconfig.rust_analyzer.setup({
            settings = {
              ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                checkOnSave = { command = "clippy" },
              }
            }
          })
        '';
      }
    ];
    extraPackages = with pkgs; [
      tree-sitter
      nixd
      pyright
      rust-analyzer
      clippy

			# Telescope deps:
			ripgrep
			fd
    ];
  };
}
