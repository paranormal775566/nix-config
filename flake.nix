{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts-pkgs = {
      url = "github:paranormal775566/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      
      systems = ["x86_64-linux"];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;
    in
    {
      inherit lib;

      nixosConfigurations = {
        desktop = lib.nixosSystem {
          modules = [
            ./desktop/nixos
          ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        "admin@desktop" = lib.homeManagerConfiguration {
          modules = [
            ./desktop/home.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}