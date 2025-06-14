{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "xzvf";
  home.homeDirectory = "/home/xzvf";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  imports = [
    ./modules/pkgsets/clipkgs.nix
    ./home/zsh/zsh.nix
    ./home/tmux/tmux.nix
    ./home/neovim/neovim.nix
  ];

  # MISC
  programs.fzf.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
