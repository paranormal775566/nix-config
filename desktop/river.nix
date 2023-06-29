{ nixpkgs, pkgs, ... }: {
  services.xserver = {
    enable = true;

    displayManager = {
      defaultSession = "none+river";
      lightdm.enable = true;

      autoLogin = {
        enable = true;
        user = "admin";
      };
    };

    windowManager.session = [{
      name = "river";
      start = ''
        ${pkgs.river}/bin/river &
        waitPID=$!
      '';
    }];
  };

  environment.systemPackages = with pkgs; [
    river
  ];
}
