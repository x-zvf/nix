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
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = null;
    extraConfig = lib.fileContents ./sway.conf;
  };
  systemd.user.services.kanshi = {
    Unit.Description = "kanshi daemon";
    Service = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c ${./kanshi_config}'';
    };
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      clock = true;
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      effect-blur = "16x16";
    };
  };

  systemd.user.services.swaylock = {
    Unit.Description = "Lock screen";
    Service.ExecStart = "${pkgs.swaylock-effects}/bin/swaylock";
  };

  services.wpaperd = {
    enable = true;
    settings = {
      any = {
        path = ../../res/wal;
        mode = "center";
        sorting = "random";
        duration = "15m";
      };
    };
  };

  programs.waybar = {
    enable = true;
    settings.mainBar = lib.importJSON ./config.jsonc;
    style = lib.fileContents ./style.css;
  };

  home.file."${config.xdg.configHome}/rofi/config.rasi".source = ./config.rasi;
  home.file."${config.xdg.configHome}/.config/scripts" = {
    source = ./scripts;
    recursive = true;
  };
}
