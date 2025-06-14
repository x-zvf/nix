{
  config,
  pkgs,
  ...
} @ args: let
  ipePkg = (import ../ipe.nix) args;
  input-leapPkg = (import ../input-leap.nix) args;
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
    #pympress
    (pympress.overrideAttrs (prev: {
      version = "1.8.5+e5da914";
      src = fetchFromGitHub {
        owner = "Cimbali";
        repo = "pympress";
        rev = "e5da914ecb2f5beb6298225cde510e5ff07d02bc";
        sha256 = "sha256-9n/xfKwN85zqP/5wGjkRbjYo4q40yJE1ABmi40Fz9dk=";
      };
      buildInputs = prev.buildInputs ++ [python3Packages.babel];
    }))
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
    (bottles.override {removeWarningPopup = true;})
    pferd
    timewarrior
    yt-dlp
    pandoc
    texliveFull

    spotify

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
