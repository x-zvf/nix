{ config, pkgs, ... }:

{
  home.username = "xzvf";
  home.homeDirectory = "/home/xzvf";
  #home.stateVersion = "23.11"; # Please read the comment before changing.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    clang
    firefox
    kate
    thunderbird
    alacritty
    kitty
    fastfetch
    (nerdfonts.override { fonts = [ "FiraCode" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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

  programs.home-manager.enable = true;
}
