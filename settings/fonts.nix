{ pkgs, apple-fonts-pkgs }: {
  fonts = {
    fonts = with pkgs; with apple-fonts-pkgs; [
      hack-font

      apple-fonts.sf-pro
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "hack" ];
      };
    };
  };
}