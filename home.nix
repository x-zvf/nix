{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "xzvf";
  home.homeDirectory = "/home/xzvf";
  home.stateVersion = "24.05";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  imports = [
    ./home/packages.nix
    ./home/zsh/zsh.nix
    ./home/tmux/tmux.nix
    ./home/neovim/neovim.nix
  ];

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Fira Code";
      font_size = 11;
      enable_audio_bell = "no";
      background_opacity = "0.85";
      close_on_child_death = "yes";
    };
  };
  programs.fzf.enable = true;

  fonts.fontconfig.enable = true;

  home.file = {
    ".gdbinit".text = ''
      set debuginfod enabled on
      set auto-load safe-path /
    '';
    ".gnupg/gpg-agent.conf".text = ''
      default-cache-ttl 1000000
      max-cache-ttl 1000000
    '';

    ".gitconfig".text = ''
      [user]
      	email = peter@bohner.me
      	name = Péter Bohner (xzvf)
      [pull]
      	rebase = true
      [credential]
      	helper = store
    '';
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
    ];
  };

  programs.home-manager.enable = true;
}
