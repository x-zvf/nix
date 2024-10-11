{...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      font_family = "Fira Code";
      font_size = 11;
      enable_audio_bell = "no";
      background_opacity = "0.85";
      close_on_child_death = "yes";
      remember_window_size = "no";
      initial_window_width = "120c";
      initial_window_height = "35c";
      confirm_os_window_close = 0;
    };
  };
}
