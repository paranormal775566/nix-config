{ nixpkgs, pkgs, ... }: {
  services.xserver = {
    enable = true;

    windowManager.dwm.enable = true;

    displayManager = {
      defaultSession = "none+dwm";
      lightdm.enable = true;

      autoLogin = {
        enable = true;
        user = "admin";
      };
    };
  };

  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        patches = oldAttrs.patches ++ [
          #./dwm.patch
        ];
        src = ./dwm;
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    dmenu
  ];
}
