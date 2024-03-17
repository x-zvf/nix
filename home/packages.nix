{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    alacritty
    bitwarden
    easyeffects

    # firefox
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {pipewireSupport = true;}) {})

    homebank
    libreoffice
    mpv
    nextcloud-client
    rambox
    thunderbird
    chromium
    vlc

    # cli tools
    bat
    fastfetch
    file
    glances
    lsd
    pferd
    tree
    wl-clipboard
    yt-dlp

    # Fonts
    nerdfonts
    fira-code
  ];
}
