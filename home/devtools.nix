{pkgs, ...}: {
  imports = [
    ./neovim/neovim.nix
  ];
  home.packages = with pkgs; [
    jetbrains.datagrip
    jetbrains.idea-ultimate
    sublime-merge

    clang
    clang-tools
    cmake
    gnumake
    go
    ghc
    jdk21
    swiProlog
    python313Full
    zig
    shellcheck
    nodejs_22
    corepack_22
    rust-bin.nightly.latest.default
    alejandra

    insomnia

    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.clion
    jetbrains.clion

    gh
    glab
    htmlq
    jq
    ripgrep
    ripgrep-all
  ];
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
    ];
  };

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
}
