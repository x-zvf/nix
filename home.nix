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
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
