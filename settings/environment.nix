{ pkgs }: {
  environment = {
    shells = [ pkgs.zsh ];

    systemPackages = with pkgs; [
      helix
    ];
  };
}
