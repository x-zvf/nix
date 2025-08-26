{ pkgs, builtins, ... }:
{
  imports = [
    #./neovim/neovim.nix
  ];
  home.packages = with pkgs; [
    #android-studio
    #jetbrains.datagrip
    #jetbrains.idea-ultimate
    #jetbrains.pycharm-professional
    #jetbrains.clion
    insomnia
    sublime-merge
    sublime4
    ghidra
    emacs

    binwalk
    clang
    clang-tools
    gnumake
    clojure
    clojure-lsp
    leiningen
    babashka
    cmake
    ghc
    swi-prolog
    zig
    shellcheck
    hugo
    sqlite
    postgresql

    #js
    nodejs_22
    corepack_22
    prettierd
    typescript
    typescript-language-server
    tailwindcss
    tailwindcss-language-server
    emmet-language-server
    nodePackages.live-server

    #go
    go
    gopls
    air
    sqlc

    #rust
    #rust-bin.nightly.latest.default
    rustc
    rustfmt
    rust-analyzer
    cargo

    #nix
    nixfmt-rfc-style
    deadnix
    statix
    nil

    #python
    (python3.withPackages (pp: [
      pp.pandas
      pp.numpy
      pp.matplotlib
      pp.jupyter
    ]))

    black
    isort
    pyright

    #lua
    lua-language-server
    stylua

    #misc
    ltex-ls
    typst
    tinymist
    cloc

    hcloud
    delta
    gh
    glab

    libtool

    platformio
    avrdude

    (mathematica.override {
      source = pkgs.fetchurl {
        url = "https://share.bohner.me/software/Wolfram_14.2.1_LIN_Bndl.sh";
        sha256 = "sha256-DcZbetr5wO3i/DkchgpsW3RGHfa1PslA4fK+bRQ68Bg=";
      };
    })
  ];
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      platformio.platformio-vscode-ide
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
