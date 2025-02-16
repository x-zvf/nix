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
    ./home/devtools.nix
    ./home/packages.nix
    ./home/clipkgs.nix
    ./home/zsh/zsh.nix
    ./home/kitty/kitty.nix
    ./home/tmux/tmux.nix
    ./home/neovim/neovim.nix
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

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    XDG_CURRENT_DESKTOP = "KDE";
    NIXOS_OZONE_WL = "1";
  };
}
