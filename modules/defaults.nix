{ ... }:
{
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "5s";
  };

  time.timeZone = "Europe/Berlin";
  console.keyMap = "uk";
  i18n.defaultLocale = "en_GB.UTF-8";

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };
}
