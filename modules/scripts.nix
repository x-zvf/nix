{
  home,
  config,
  ...
}: {
  home.file."${config.xdg.configHome}/scripts" = {
    source = ../scripts;
    recursive = true;
  };
}
