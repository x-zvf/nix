{...}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "Fira Code Nerd Font Mono";
      font-size = 11;
      background-opacity = 0.85;
      background-blur = true;
      quit-after-last-window-closed = false;
      confirm-close-surface = false;
      gtk-single-instance = true;
      scrollback-limit = 1000000;
      window-height = 35;
      window-width = 120;
    };
  };
}
