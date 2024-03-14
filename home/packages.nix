{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # desktop applications
    alacritty
    bitwarden
    easyeffects

    # firefox
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {pipewireSupport = true;}) {})

    homebank
    jetbrains.datagrip
    jetbrains.idea-ultimate
    libreoffice
    mpv
    nextcloud-client
    rambox
    thunderbird
    chromium
    vlc

    # programming languages
    clang
    go
    ghc
    jdk21
    swiProlog
    python313Full
    zig
    shellcheck
    nodejs_21
    corepack_21
    rust-bin.nightly.latest.default

    #nix-tools
    alejandra

    # cli tools
    bat
    fastfetch
    file
    gh
    glab
    glances
    htmlq
    jq
    lsd
    pferd
    ripgrep
    ripgrep-all
    stow
    tree
    wl-clipboard
    yt-dlp

    # Fonts
    nerdfonts
    fira-code
  ];
}
