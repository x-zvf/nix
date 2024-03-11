{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 * * * *      xzvf    . /etc/profile; pferd > /home/xzvf/ilias/pferd.log"
    ];
  };
}
