{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.username = "xzvf";
  home.homeDirectory = "/home/xzvf";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  imports = [
    ./modules/pkgsets/devtools.nix
    ./modules/pkgsets/home-packages.nix
    ./modules/pkgsets/clipkgs.nix
    ./modules/zsh/zsh.nix
    ./modules/ghostty.nix
    ./modules/tmux/tmux.nix
    ./modules/neovim/neovim.nix
    # ./modules/sway-session.nix
    ./modules/scripts.nix

    ./modules/distrobox.nix
  ];

  # MISC
  programs.fzf.enable = true;
  fonts.fontconfig.enable = true;
  services.easyeffects.enable = true; # requires dconf
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  dconf = {
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
  #qt = {
  #  enable = true;
  #  #style.name = "adwaita-dark";
  #  #platformTheme.name = "adwaita";
  #};

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    XDG_CURRENT_DESKTOP = "KDE";
    NIXOS_OZONE_WL = "1";
  };
}
