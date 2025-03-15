{ pkgs, ... }:
let
  toLua = str: "lua << EOF\n${str}\nEOF\n"
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
					command = "nohlsearch"
			})

			-- Shortcuts
			vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
			vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
			vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
			vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
			vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
			vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
  	'';
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
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
			]));
			nvim-treesitter-textobjects

			# Telescope
			{
        plugin = telescope-nvim;
				config = toLua "require(\"telescope\").setup()"
			}
      plenary-nvim
    ];
    extraPackages = with pkgs; [
      tree-sitter
      nixd

			# Telescope deps:
			ripgrep
			fd
    ];
  };
}
