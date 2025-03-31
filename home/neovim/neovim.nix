{
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      vim-sleuth
      gitsigns-nvim

      plenary-nvim #required by telescope
      telescope-nvim
      telescope-ui-select-nvim
      telescope-fzf-native-nvim

      lazydev-nvim
      luvit-meta

      #mini
      conform-nvim
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-spell
      fidget-nvim
      luasnip
      cmp_luasnip
      nvim-cmp
      cmp-path
      todo-comments-nvim
      ltex_extra-nvim
      typst-preview-nvim
      comment-nvim

      trouble-nvim

      kanagawa-nvim

      lspkind-nvim
      copilot-lua
      copilot-cmp
      copilot-lualine
      lualine-nvim
    ];
    extraLuaConfig = lib.fileContents ./init.lua;
  };
}
