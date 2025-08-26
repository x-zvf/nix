{ pkgs, ... }:
{
  home.packages = with pkgs; [
    distrobox
  ];
  xdg.desktopEntries = {
    xair = {
      name = "X-Air Edit";
      exec = "distrobox enter deb  -- .local/bin/X-AIR-Edit";
      terminal = false;
      categories = [ ];

    };
  };

}
