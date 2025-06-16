{
  pkgs,
  lib,
  home,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    rofi
    kanshi
    wdisplays
    wpaperd
    kdePackages.kwallet
    pavucontrol
    dunst
    networkmanagerapplet
    brightnessctl
    playerctl
    pasystray
    cliphist
    slurp
    grim
  ];

  imports = [
    ./sway/sway.nix
    ./rofi/rofi.nix
    ./kanshi/kanshi.nix
    ./waybar/waybar.nix
    ./swaylock/swaylock.nix
    ./wpaperd.nix
  ];
}
