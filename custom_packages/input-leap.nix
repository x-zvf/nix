{ pkgs, ...}:
with pkgs;
  stdenv.mkDerivation rec {
  pname = "input-leap";
  version = "master-${src.rev}";

  src = fetchFromGitHub {
    owner = "input-leap";
    repo = "input-leap";
    rev = "53d2a329d4600c71efad56f19b4b5185aaeb4829";
    hash = "sha256-iT+eagV5PvYDZE3L1U858usLZVKQW1hglN7EjTJWmrc=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ pkg-config cmake wrapGAppsHook3 libsForQt5.qt5.qttools ];
  buildInputs = [
    curl libsForQt5.qtbase  avahi avahi-compat qt5.qtwayland
    xorg.libX11 xorg.libXext xorg.libXtst xorg.libXinerama xorg.libXrandr xorg.libXdmcp xorg.libICE xorg.libSM libei libportal ];

  cmakeFlags = [
    "-DINPUTLEAP_REVISION=${builtins.substring 0 8 src.rev}"
    "-DINPUTLEAP_BUILD_LIBEI=ON"];

  dontWrapGApps = true;
  dontWrapQtApps = true;
  preFixup = ''
    qtWrapperArgs+=(
      "''${gappsWrapperArgs[@]}"
        --prefix PATH : "${lib.makeBinPath [ openssl ]}"
    )
  '';

  postFixup = ''
    substituteInPlace $out/share/applications/io.github.input_leap.InputLeap.desktop \
      --replace "Exec=input-leap" "Exec=$out/bin/input-leap"
  '';

  meta = {
    description = "Open-source KVM software";
    longDescription = ''
      Input Leap is software that mimics the functionality of a KVM switch, which historically
      would allow you to use a single keyboard and mouse to control multiple computers by
      physically turning a dial on the box to switch the machine you're controlling at any
      given moment. Input Leap does this in software, allowing you to tell it which machine
      to control by moving your mouse to the edge of the screen, or by using a keypress
      to switch focus to a different system.
    '';
    homepage = "https://github.com/input-leap/input-leap";
    license = lib.licenses.gpl2Plus;
    maintainers = with lib.maintainers; [ kovirobi phryneas twey shymega ];
    platforms = lib.platforms.linux;
  };
}
