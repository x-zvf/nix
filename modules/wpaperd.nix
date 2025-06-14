{...}: {
  services.wpaperd = {
    enable = true;
    settings = {
      any = {
        path = ../res/wal;
        mode = "center";
        sorting = "random";
        duration = "15m";
      };
    };
  };
}
