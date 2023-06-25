{ pkgs }: {
  shells = [ pkgs.zsh ];

  systemPackages = with pkgs; [
    helix
  ];
}
