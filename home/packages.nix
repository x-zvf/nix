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
    bitwarden-desktop
    chromium
    easyeffects

    # firefox
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {pipewireSupport = true;}) {})

    homebank
    libreoffice
    mpv
    qalculate-qt
    nextcloud-client
    pympress
    signal-desktop
    tor-browser
    gimp
    krita
    blender
    thunderbird
    vlc
    texliveFull
    yakuake

    # cli tools
    bat
    dig
    distrobox
    fastfetch
    file
    fd
    glances
    lsd
    paps
    pferd
    traceroute
    timewarrior
    tree
    yt-dlp
    xxd
    hexdump
    pandoc
    texliveFull

    # Fonts
    nerdfonts
    fira-code

    # nix
    nvd

    # unfree
    rambox
    # custom
    ipePkg
    #input-leapPkg
  ];
}
