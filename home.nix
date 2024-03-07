{ config, pkgs, ... }:

{
  home.username = "xzvf";
  home.homeDirectory = "/home/xzvf";
  home.stateVersion = "24.05";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  imports = [
    ./home/packages.nix
    ./home/zsh/zsh.nix
  ];

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "FiraCode Nerd Font";
      font_size = 11;
      enable_audio_bell = "no";
      background_opacity = "0.85";
      close_on_child_detach = "yes";
    };
  };

  home.file = {
    ".gdbinit".text = ''
set debuginfod enabled on
set auto-load safe-path /
    '';
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
    ];
  };

  programs.home-manager.enable = true;
}
