{
  pkgs,
  lib,
  home,
  config,
  ...
}: {
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
