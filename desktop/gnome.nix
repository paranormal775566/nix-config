{ pkgs, ... }: {
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  programs.dconf.enable = true;

  programs.xwayland.enable = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome.dconf-editor
    gnome.gnome-tweaks

    gnomeExtensions.dock-from-dash
    gnomeExtensions.freon
    gnomeExtensions.just-perfection
    gnomeExtensions.blur-my-shell
    gnomeExtensions.unite
    gnomeExtensions.appindicator

    whitesur-gtk-theme
    whitesur-icon-theme
    apple-cursor
  ];
}
