{ lib, ... }:
{
  systemd.network.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.resolved.enable = true;

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  #NOTE: one must use zerotier-systemd-manager to get dns to work, for now
  #NOTE: manual approval in my.zerotier.com required - hence this netwokid can
  #      be in public
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "272f5eae16696d44" ];
    #generateSystemdNetworkdConfig = true;
  };

}
