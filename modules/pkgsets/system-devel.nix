{ pkgs, ... }:
{

  documentation = {
    dev.enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
  };

  programs = {
    java.enable = true;
    mtr.enable = true;
    nix-ld.enable = true;
  };

  services.locate = {
    enable = true;
    package = pkgs.plocate;
    interval = "hourly";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w" # sublime4
  ];

  services.udev.packages = [
    pkgs.platformio-core
    pkgs.openocd
  ];
}
