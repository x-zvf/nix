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


    # cli tools
    bat
    clang
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
