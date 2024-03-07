{config, pkgs, ... }:
{

  programs.tmux = {
    enable = true;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    extraConfig = builtins.readFile ./tmux.conf;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      #mkTmuxPlugin {
      #  pluginName = "tmux-powerline";
      #  version 
      #};
    ];
  };

}
