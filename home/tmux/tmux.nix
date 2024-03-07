{config, pkgs, ... }:
let
 tmuxPowerline = 
        pkgs.tmuxPlugins.mkTmuxPlugin rec {
          pluginName = "tmux-powerline";
          version = "3.0.0";
          src = pkgs.fetchFromGitHub {
            owner = "erikw";
            repo = "tmux-powerline";
            rev = "v${version}";
	    sha256 = "25uG7OI8OHkdZ3GrTxG1ETNeDtW1K+sHu2DfJtVHVbk=";
          };
	  rtpFilePath = "main.tmux";
        };
in
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
	tmuxPowerline
      ];
    };
  };
}
