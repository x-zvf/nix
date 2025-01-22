{
  config,
  pkgs,
  ...
} @ args: let
  ipePkg = (import ../custom_packages/ipe.nix) args;
  input-leapPkg = (import ../custom_packages/input-leap.nix) args;
in {
  home.packages = with pkgs; [
    bat
    cht-sh
    dig
    fastfetch
    fd
    file
    glances
    hexdump
    htmlq
    hyperfine
    jq
    lsd
    openssl
    ripgrep
    ripgrep-all
    sequoia
    sshfs
    traceroute
    tree
    xxd
    zip
  ];
}
