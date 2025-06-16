{
  home,
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [ rofi ];
  home.file."${config.xdg.configHome}/rofi/config.rasi".source = ./config.rasi;
}
