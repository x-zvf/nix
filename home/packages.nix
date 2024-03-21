{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    alacritty
    bitwarden
    chromium
    easyeffects

    # firefox
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {pipewireSupport = true;}) {})

    homebank
    libreoffice
    mathematica
    mpv
    nextcloud-client
    rambox
    signal-desktop
    thunderbird
    vlc

    # cli tools
    bat
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
  ];
}
