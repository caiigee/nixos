{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      set foldmethod=expr
      set foldexpr=nvim_treesitter#foldexpr()
      set foldenable
      set foldlevel=99
      set foldcolumn=1
      set shiftwidth=2
      set tabstop=2
      set clipboard+=unnamedplus

      lua << EOF
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "nix" },
        highlight = { enable = true },
        indent = { enable = true },
        fold = { enable = true }
      }
      EOF

      lua << EOF
      local lspconfig = require('lspconfig')
      lspconfig.nixd.setup {}
      EOF
      
      lua << EOF
      require('telescope').setup{}
      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {})
      EOF
      
      lua << EOF
      require("auto-save").setup({
        execution_message = "Auto-Saved",
        debounce_delay = 5000  -- Saves every 5 seconds
      })
      EOF
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter
      nvim-lspconfig
      telescope-nvim
      plenary-nvim
      auto-save-nvim
    ];
    extraPackages = with pkgs; [
      tree-sitter
      nixd
    ];
  };
}
