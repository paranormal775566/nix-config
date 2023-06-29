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

          # alpha - bar transparency - needs to be manually patched in

          # alttab - adds alt-tab functionality - needs to be manually patched in

          # fakefullscreen - clients fullscreen to their space
          (super.fetchpatch {
            url = "https://dwm.suckless.org/patches/fakefullscreen/dwm-fakefullscreen-20210714-138b405.diff";
            sha256 = "1nf5bxsk3xvkygff19i7ynmj08xf7wnj5qc95asiapnbcdq1r7k9";
          })

          # fullgaps - gaps between client windows, screen frame, and master/stack
          (super.fetchpatch {
            url = "https://dwm.suckless.org/patches/fullgaps/dwm-fullgaps-6.4.diff";
            sha256 = "05azc4s8yyb5cpy6s5f4gvqy79w7n7gzm9wdyriscz83xhycvwhf";
          })
          
        ];
        src = ./dwm;
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    dmenu
  ];
}
