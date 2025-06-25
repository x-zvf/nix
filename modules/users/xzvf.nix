{ pkgs, ... }:
{
  users.users.xzvf = {
    isNormalUser = true;
    initialPassword = "changeme";
    description = "Péter Bohner";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "networkmanager"
      "docker"
      "video"
    ];
  };

}
