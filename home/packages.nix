{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # desktop applications
    alacritty
    bitwarden
    easyeffects

    # firefox
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {pipewireSupport = true;}) {})

    homebank
    jetbrains.datagrip
    jetbrains.idea-ultimate
    libreoffice
    mpv
    nextcloud-client
    rambox
    thunderbird
    vlc

    # other programming languages via devshells
    python3Full

    # cli tools
    bat
    fastfetch
    gh
    glab
    glances
    lsd
    pferd
    ripgrep
    ripgrep-all
    stow
    tree
    yt-dlp

    # Fonts
    nerdfonts
    fira-code
  ];
}
