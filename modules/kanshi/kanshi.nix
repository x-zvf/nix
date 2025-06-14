{pkgs, ...}: {
  systemd.user.services.kanshi = {
    Unit.Description = "kanshi daemon";
    Service = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c ${./kanshi_config}'';
    };
  };
}
