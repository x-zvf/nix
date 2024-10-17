{pkgs, ...}: {
  imports = [
    #./neovim/neovim.nix
  ];
  home.packages = with pkgs; [
    jetbrains.datagrip
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.clion
    insomnia
    sublime-merge
    ghidra
    emacs
    devdocs-desktop

    sequoia
    openssl

    binwalk
    clang
    clang-tools
    gnumake
    clojure
    cmake
    ghc
    swi-prolog
    zig
    shellcheck

    #js
    nodejs_22
    corepack_22
    prettierd
    typescript
    typescript-language-server
    tailwindcss
    tailwindcss-language-server
    emmet-language-server
    live-server

    #go
    go
    gopls

    #rust
    #rust-bin.nightly.latest.default
    rustc
    rustfmt
    cargo

    #nix
    alejandra
    deadnix
    statix
    nil

    #python
    python313Full
    black
    isort
    pyright

    #lua
    lua-language-server
    stylua

    #misc
    ltex-ls

    cht-sh
    hcloud
    delta
    gh
    glab
    htmlq
    jq
    ripgrep
    ripgrep-all
    zip

    libtool
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
      [commit]
        gpgsign = true
      [gpg]
        format = ssh
      [core]
        pager = delta
      [user]
        email = peter@bohner.me
        name = Péter Bohner (xzvf)
        signingkey = ~/.ssh/id_ed25519.pub
      [push]
        autoSetupRemote = true
        default = current
      [pull]
        rebase = true
      [credential]
        helper = store
      [init]
        defaultBranch = master
    '';
  };
}
