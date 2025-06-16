{ pkgs, ... }:
{
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
}
