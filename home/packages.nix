{
  config,
  pkgs,
  ...
} @ args: let
  ipePkg = (import ../custom_packages/ipe.nix) args;
  input-leapPkg = (import ../custom_packages/input-leap.nix) args;
in {
  home.packages = with pkgs; [
    anki
    bitwarden-desktop
    (ungoogled-chromium.override {
      commandLineArgs = [
      ];
      enableWideVine = true;
    })
    easyeffects

    # firefox
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {pipewireSupport = true;}) {})

    (homebank.overrideAttrs
      (oldAttrs: {
        postInstall =
          (oldAttrs.postInstall or "")
          + ''
            wrapProgram $out/bin/homebank --set GDK_BACKEND x11
          '';
      }))

    libreoffice
    onlyoffice-bin
    mpv
    qalculate-qt
    nextcloud-client
    pympress
    signal-desktop-bin
    ferdium
    tor-browser
    gimp
    krita
    audacity
    inkscape
    blender-hip
    nautilus
    thunderbird
    vlc
    texliveFull
    kdePackages.yakuake
    kdePackages.kdeplasma-addons
    xournalpp
    obsidian

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
    amdgpu_top

    # custom
    ipePkg
    #input-leapPkg
  ];
}
