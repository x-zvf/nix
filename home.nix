{ config, pkgs, ... }:

{
  home.username = "xzvf";
  home.homeDirectory = "/home/xzvf";
  #home.stateVersion = "23.11"; # Please read the comment before changing.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    clang
    firefox
    kate
    thunderbird
    alacritty
    kitty
    fastfetch
    bitwarden
    jetbrains.idea-ultimate
    jetbrains.datagrip
    nextcloud-client
    mpv
    vlc
    pferd
    rambox
    homebank
  ];

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
