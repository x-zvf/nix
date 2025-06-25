{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zfs-autobackup
  ];

  services.cron.systemCronJobs = [
    "10 * * * *     root    . /etc/profile; zfs-autobackup -v --ssh-target gabackup --ssh-config /home/xzvf/.ssh/config togallium RustBucket/backups/rubidium"
  ];
}
