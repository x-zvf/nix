{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # desktop applications
    alacritty
    bitwarden
    easyeffects
    firefox
    homebank
    jetbrains.datagrip
    jetbrains.idea-ultimate
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

    # misc
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}
