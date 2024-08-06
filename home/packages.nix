{
  config,
  pkgs,
  ...
} @ args: let
  ipePkg = (import ../custom_packages/ipe.nix) args;
  input-leapPkg = (import ../custom_packages/input-leap.nix) args;
in {
  home.packages = with pkgs; [
    alacritty
    anki
    #bitwarden-desktop
    chromium
    easyeffects

    # firefox
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {pipewireSupport = true;}) {})

    homebank
    libreoffice
    mpv
    nextcloud-client
    pympress
    signal-desktop
    thunderbird
    vlc
    texliveFull

    # cli tools
    bat
    dig
    distrobox
    fastfetch
    file
    glances
    lsd
    paps
    pferd
    traceroute
    tree
    wl-clipboard
    yt-dlp

    # Fonts
    nerdfonts
    fira-code

    # nix
    nvd

    # unfree
    rambox
    mathematica
    # custom
    ipePkg
    #input-leapPkg
  ];
}
