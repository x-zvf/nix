{pkgs, ...}: {
  home.packages = with pkgs; [
    sway
    swaybg
    swayidle
    shikane
    wofi
    blueman
    wdisplays
    sway-contrib.grimshot
    networkmanagerapplet
    lxqt.lxqt-policykit
    xfce.xfce4-notifyd
  ];

  programs.swaylock = {
    enable = true;
  };
  home.file = {
    shikaneconf = {
    	source = ./shikane.toml;
	target = ".config/shikane/config.toml";
    };
  };

   programs.waybar = {
    enable = true;
    #style = ./waybarstyle.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 20;
        modules-left = [ "sway/workspaces" ];
        modules-right = [ "disk" "pulseaudio" "cpu" "network#eth" "network#wireless" "battery" "temperature" "clock" "tray" ];

        "tray" = {
          spacing = 10;
          icon-size = 20;
        };

        "pulseaudio" =
          {
            on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
            format = "{volume}%";
            format-muted = "muted";
          };

        "sway/workspaces" = {
          all-outputs = true;
        };

        "clock" = {
          interval = "1R";
          format = "{:%H:%M}";
          format-alt = "{:%d.%m.%Y %H:%M:%S}";
        };

        "battery" = {
          format = "BAT: {capacity}%";
          bat = "BAT0";
          full-at = "94";
        };

        "temperature" = {
          thermal-zone = 0;
          critical-threshold = 70;
          format = "{temperatureC}°C";
          interval = 2;
          hwmon-path-abs = "/sys/devices/platform/coretemp.0/hwmon";
          input-filename = "temp1_input";
        };

        "network#eth" = {
          interval = 5;
          interface = "enp12s0";
          format = "{ipaddr}";
          format-disconnected = "disconnected";
        };
        "network#wireless" = {
          interval = 5;
          interface = "wlp82s0";
          format = "{ipaddr}@{essid} ({signalStrength}%)";
          format-disconnected = "disconnected";
        };

        "disk" = {
          interval = 30;
          path = "/";
          tooltip-format = "\"{path}\": {used}/{total} ({percentage_used}%)";
          format = "\"{path}\": {percentage_used}%";
        };
      };
    };
  };


  wayland.windowManager.sway =
    let mod = "Mod4"; in {
    enable = true;

    config = rec {
      modifier = mod;
      terminal = "kitty"; 
      fonts = { names = [ "Fira Code" ];};
      output."*".bg = "${../../res/wallpaper01.jpg} fill";
      input = {
        "*" = {
          xkb_options = "caps:escape,escape:caps,compose:ralt";
          xkb_layout = "gb";
        };
      };
      keybindings = {
        "${mod}+Return" = "exec kitty";
        "${mod}+Shift+q" = "kill";
        "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show combi -config ~/.config/rofi/config.rasi";

        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        "${mod}+s" = "splith";
        "${mod}+v" = "splitv";
        "${mod}+f" = "fullscreen toggle";

        "${mod}+w" = "layout stacking";
        "${mod}+t" = "layout tabbed";
        "${mod}+e" = "layout toggle split";

        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";

        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";

        "${mod}+Shift+1" =
          "move container to workspace number 1";
        "${mod}+Shift+2" =
          "move container to workspace number 2";
        "${mod}+Shift+3" =
          "move container to workspace number 3";
        "${mod}+Shift+4" =
          "move container to workspace number 4";
        "${mod}+Shift+5" =
          "move container to workspace number 5";
        "${mod}+Shift+6" =
          "move container to workspace number 6";
        "${mod}+Shift+7" =
          "move container to workspace number 7";
        "${mod}+Shift+8" =
          "move container to workspace number 8";
        "${mod}+Shift+9" =
          "move container to workspace number 9";
        "${mod}+Shift+0" =
          "move container to workspace number 10";

        "${mod}+Shift+r" = "reload";
        "${mod}+Shift+e" =
          "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

        "${mod}+r" = "mode resize";
      };

      startup = [
        # Launch Firefox on start
	{command = "shikane";}
	{command = "waybar";}
        {command = "firefox";}
        {command = "thunderbird";}
        {command = "rambox";}
	{command = "signal-desktop";}
        {command = "nextcloud";}
        {command = "blueman-applet";}
        {command = "nm-applet";}
      ];
    };
  };

}
