{ pkgs, ... }:

let
  dotfiles = import ../dotfiles/default.nix;
in
{
  programs.home-manager.enable = true;

  home = {
    username = "admin";
    homeDirectory = "home/admin";
    stateVersion = "23.05";

    packages = with pkgs; [
      helix

      bat

      git
      neofetch

      firefox
      cider
    ];

    file = dotfiles // {};

    sessionVariables = {
      EDITOR = "hx";
      BROWSER = "firefox";
      TERMINAL = "alacritty";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };
}
