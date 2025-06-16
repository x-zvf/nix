{ lib, ... }:
{
  programs.waybar = {
    enable = true;
    settings.mainBar = lib.importJSON ./config.jsonc;
    style = lib.fileContents ./style.css;
  };
}
