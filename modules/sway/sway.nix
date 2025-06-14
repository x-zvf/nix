{
  pkgs,
  lib,
  home,
  config,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = null;
    extraConfig = lib.fileContents ./sway.conf;
  };
}
