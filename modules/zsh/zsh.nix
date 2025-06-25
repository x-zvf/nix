{ ... }:
{
  programs.zsh = {
    enable = true;
    antidote.enable = true;
    enableVteIntegration = true;
    defaultKeymap = "viins";

    antidote.plugins = [
      "zsh-users/zsh-autosuggestions"
      "zsh-users/zsh-syntax-highlighting"
      "romkatv/powerlevel10k kind:fpath"
    ];
    initContent = ''
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
      gucp() {
        git add -u
          git commit -m "$1"
          git push
      }
      # proper up-arrow searching
      autoload -Uz history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      bindkey "$terminfo[kcuu1]" history-beginning-search-backward-end
      bindkey "$terminfo[kcud1]" history-beginning-search-forward-end

      [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
      [[ ! -f ${./zsh-syntax-highlighting.sh} ]] || source ${./zsh-syntax-highlighting.sh}
      autoload -Uz promptinit && promptinit && prompt powerlevel10k

      setopt interactivecomments
      #ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=13'
      export PATH="/home/xzvf/.config/scripts:$PATH"
    '';

    shellAliases = {
      "v" = "nvim";
      "sv" = "sudo -e";
      "l" = "lsd -lh";
      "la" = "lsd -lah";
      "b" = "bat";
      "o" = "xdg-open";

      "tree" = "tree -C";

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

      # Nix
      "np" = "NIXPKGS_ALLOW_UNFREE=1 nix-shell --run zsh -p";
      "nr" = "NIXPKGS_ALLOW_UNFREE=1 nix run --impure";
      "snr" = "sudo nixos-rebuild --flake '/home/xzvf/nix#rubidium'";
      "matlab" = "nix run gitlab:doronbehar/nix-matlab";
      "mathematica" = "NIXPKGS_ALLOW_UNFREE=1 nix-shell -p mathematica --run wolframnb";

      "glances" = "glances --enable-plugin sensors";
      "ssh" = "TERM=xterm-256color ssh";
      "unfuckadb" = "sudo adb kill-server; sudo adb start-server; adb devices";
      "unfuckzt" =
        "sudo systemctl restart zerotierone.service systemd-resolved.service systemd-networkd.service NetworkManager";
      "yt-dl-mp3" =
        "yt-dlp -x --audio-format mp3 --audio-quality 0 -i --add-metadata --metadata-from-title";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
