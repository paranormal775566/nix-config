{ pkgs, apple-fonts }: {
  fontDir.enable = true;
  fonts = with pkgs; [
    hack-font

    apple-fonts.sf-pro
  ];

  fontconfig = {
    defaultFonts = {
      monospace = [ "hack" ];
    };
  };
}
