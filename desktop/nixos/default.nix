{ pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix    

    #../gnome.nix
    ../dwm.nix
    #../river.nix
  ];

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;   
  };

  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
  
    users.admin = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
