{ pkgs, ... }:
{
  config = {
    programs.tmux = {
      enable = true;
      historyLimit = 100000;
      keyMode = "vi";
      mouse = true;
      clock24 = true;
      baseIndex = 1;
      extraConfig = builtins.readFile ./tmux.conf;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        {
          plugin = dracula;
          extraConfig = ''
            set -g @dracula-show-flags true
            set -g @dracula-show-powerline true
            set -g @dracula-show-fahrenheit false
            set -g @dracula-git-show-remote-status true
            set -g @dracula-plugins "battery git cpu-usage time"
            set -g @dracula-show-left-sep 
            set -g @dracula-show-right-sep 
            set -g @dracula-battery-label "  "
            set -g @dracula-show-left-icon " "
            set -g @dracula-time-format "%F %H:%M:%S"
            set -g @dracula-refresh-rate 1
          '';
        }
        tmux-thumbs
        tmux-fzf
      ];
    };
  };
}
