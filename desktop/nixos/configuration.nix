{ pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../settings    
  ];

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;   
  };

  nixpkgs.config.allowUnfree = true;

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