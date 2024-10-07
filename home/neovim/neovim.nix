{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    #inputs.nixvim.homeManagerModules.nixvim
  ];
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
      telescope-fzf-writer-nvim

      lazydev-nvim
      luvit-meta

      #mini

      conform-nvim
      nvim-lspconfig
      cmp-nvim-lsp
      fidget-nvim
      luasnip
      cmp_luasnip
      nvim-cmp
      cmp-path
      todo-comments-nvim
    ];
    extraLuaConfig = lib.fileContents ./init.lua;
  };
}
