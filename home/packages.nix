{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    clang
    firefox
    kate
    thunderbird
    alacritty
    fastfetch
    bitwarden
    jetbrains.idea-ultimate
    jetbrains.datagrip
    nextcloud-client
    mpv
    vlc
    pferd
    rambox
    homebank
    gh
    glab
  ];
}
