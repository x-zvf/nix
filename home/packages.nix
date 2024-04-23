{
  config,
  pkgs,
  ...
} @ args: let
  ipePkg = (import ../custom_packages/ipe.nix) args;
in {
  home.packages = with pkgs; [
    alacritty
    bitwarden
    chromium
    easyeffects

    # firefox
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {pipewireSupport = true;}) {})

    homebank
    libreoffice
    mpv
    nextcloud-client
    pympress
    signal-desktop
    thunderbird
    vlc

    # cli tools
    bat
    distrobox
    fastfetch
    file
    glances
    lsd
    paps
    pferd
    tree
    wl-clipboard
    yt-dlp

    # Fonts
    nerdfonts
    fira-code

    # nix
    nvd

    # unfree
    rambox
    mathematica
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.clion
    jetbrains.clion

    # custom
    ipePkg
  ];
}
