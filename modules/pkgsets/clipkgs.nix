{ pkgs, ... }:
{
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
    jq
    yq
    httpie
    hyperfine
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
