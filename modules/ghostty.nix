{...}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "Fira Code Nerd Font Mono";
      font-size = 12;
      background-opacity = 0.85;
      background-blur = true;
      quit-after-last-window-closed = false;
      confirm-close-surface = false;
      gtk-single-instance = true;
      scrollback-limit = 10485760;
      window-height = 35;
      window-width = 120;
      theme = "dracula";
    };
    themes = {
      dracula = {
        palette = [
          "0=#21222c"
          "1=#ff5555"
          "2=#50fa7b"
          "3=#f1fa8c"
          "4=#bd93f9"
          "5=#ff79c6"
          "6=#8be9fd"
          "7=#f8f8f2"
          "8=#6272a4"
          "9=#ff6e6e"
          "10=#69ff94"
          "11=#ffffa5"
          "12=#d6acff"
          "13=#ff92df"
          "14=#a4ffff"
          "15=#ffffff"
        ];
        background = "282a36";
        foreground = "f8f8f2";
        cursor-color = "f8f8f2";
        cursor-text = "282a36";
        selection-foreground = "f8f8f2";
        selection-background = "44475a";
      };
    };
  };
}
