{config, pkgs, ... }:
{
  config = {
    programs.tmux = {
      enable = true;
      historyLimit = 10000;
      keyMode = "vi";
      mouse = true;
      extraConfig = builtins.readFile ./tmux.conf;
      plugins = with pkgs.tmuxPlugins; [
        sensible
	catppuccin
	tmux-thumbs
	tmux-fzf
      ];
    };
  };
}
