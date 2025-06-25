{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "gb";
        variant = "";
      };
    };
    displayManager = {
      autoLogin = {
        enable = false;
        user = "xzvf";
      };
      #defaultSession = "sway";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
    desktopManager.plasma6.enable = true;
    printing.enable = true;
  };

  programs.sway = {
    enable = false;
    wrapperFeatures.gtk = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.dconf.enable = true;
  programs.light.enable = true;
  programs.kdeconnect.enable = true;
}
