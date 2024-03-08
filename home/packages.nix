{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # desktop applications
    alacritty
    bitwarden
    easyeffects

    # firefox
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})

    homebank
    jetbrains.datagrip
    jetbrains.idea-ultimate
    libreoffice
    mpv
    nextcloud-client
    rambox
    thunderbird
    vlc

    # languages
    clang
    python3Full

    # cli tools
    bat
    fastfetch
    gh
    glab
    glances
    lsd
    pferd
    yt-dlp
    tree

    # misc
    nerdfonts
    fira-code
  ];
}
