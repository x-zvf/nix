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
    onlyoffice-bin
    mpv
    qalculate-qt
    nextcloud-client
    pympress
    signal-desktop
    tor-browser
    gimp
    krita
    audacity
    inkscape
    blender
    nautilus
    thunderbird
    vlc
    texliveFull
    yakuake

    distrobox
    pferd
    timewarrior
    yt-dlp
    pandoc
    texliveFull

    nerd-fonts.fira-code
    nerd-fonts.fira-mono

    # nix
    nvd

    # unfree
    rambox
    # custom
    ipePkg
    #input-leapPkg
  ];
}
