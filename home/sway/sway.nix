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
    pasystray
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
        height = 25;
        spacing = 10;
        modules-left = [ "sway/workspaces" ];
        modules-right = [ "pulseaudio" "cpu" "network#eth" "network#wireless" "battery" "temperature" "clock" "tray" ];

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
          interval = 1;
          format =  "{:%Y-%m-%d %H:%M:%S}";
          format-alt = "{:%d.%m.%Y %H:%M:%S}";
        };

        "battery" = {
          format = "BAT: {capacity}%";
          bat = "BAT1";
        };

        "temperature" = {
          thermal-zone = 3;
          critical-threshold = 70;
          format = "{temperatureC}°C";
          interval = 2;
        };

        "network#eth" = {
          interval = 5;
          interface = "eth0";
          format = "{ipaddr}";
          format-disconnected = "disconnected";
        };
        "network#wireless" = {
          interval = 5;
          interface = "wlp1s0";
          format = "{ipaddr}@{essid} ({signalStrength}%)";
          format-disconnected = "disconnected";
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

      bars = [];
      input = {
        "*" = {
          xkb_options = "caps:escape,escape:caps,compose:ralt";
          xkb_layout = "gb";
	  xkb_numlock = "enabled";
	  xkb_capslock = "disabled";
	  accel_profile = "flat";
	  tap = "enabled";
        };
	"Logitech_Wireless_Mouse_MX_Master_3" = {
	};
	"2362:628:PIXA3854:00_093A:0274_Touchpad" = {
	  natural_scroll = "enabled";
	};
      };
      keybindings = {
        "${mod}+Return" = "exec kitty";
        "${mod}+Shift+q" = "kill";
        "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show combi";
	"${mod}+x" = "exec --no-startup-id swaylock -i ${../../res/wallpaper01.jpg} --ignore-empty-password --show-failed-attempts --daemonize";

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

	 "XF86MonBrightnessDown" = "exec light -U 10";
	 "XF86MonBrightnessUp" = "exec light -A 10";
	 "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";
	 "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";
	 "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";

      };
      startup = [
        # Launch Firefox on start
	#{command = "pkill shikane ; shikane"; always = true;}
	#{command = "pkill waybar ; waybar"; always = true;}
	#{command = "pkill pasystray; pasystray"; always = true;}
        #{command = "pkill blueman-applet; blueman-applet"; always = true;}
        #{command = "pkill nm-applet; nm-applet"; always = true;}
	#{command = "kwalletd";}
        #{command = "firefox";}
        #{command = "thunderbird";}
        #{command = "rambox";}
	#{command = "signal-desktop";}
        #{command = "nextcloud";}
      ];
    };
  };

}
