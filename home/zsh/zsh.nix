{config, pkgs, ... }:
{
    programs.zsh = {
      enable = true;
      antidote.enable = true;
      enableVteIntegration = true;
      defaultKeymap = "viins";

      antidote.plugins = [
        "zsh-users/zsh-autosuggestions"
        "romkatv/powerlevel10k kind:fpath"
      ];
      initExtra = ''
        mkcd() {
	    mkdir -p "$1" && cd "$1"
        }
	wttr()
	{
	    local request="wttr.in/"
	    [ "$(tput cols)" -lt 125 ] && request+='?n'
	    curl -H "Accept-Language: $\{LANG%_*}" --compressed "$request"
	}
	s() {
	    nohup $@ </dev/null >/dev/null 2>&1 &
	}

        [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
        autoload -Uz promptinit && promptinit && prompt powerlevel10k
      '';

      shellAliases = {
        "v" = "nvim";
        "sv" = "sudo -e";
        "l" = "lsd -lah";
        "b" = "bat";
        "o" = "xdg-open";
	# Git
        "ga" = "git add";
        "gu" = "git add -u; git commit -m ";
        "gpsh" = "git push";
        "gpll" = "git pull";
        "gstat" = "git status";
        "gcom" = "git commit";
        "gdiff" = "git diff";
        "gstapush" = "git stash push";
        "gstapop" = "git stash pop";

        "glances" = "glances --enable-plugin sensors";
        "ssh" = "TERM=xterm-256color ssh";
        "unfuckadb" = "sudo adb kill-server; sudo adb start-server; adb devices";
        "yt-dl-mp3" = "yt-dlp -x --audio-format mp3 --audio-quality 0 -i --add-metadata --metadata-from-title";
      };
   };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
}
