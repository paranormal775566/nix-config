{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts-pkgs = {
      url = "github:paranormal775566/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, haumea, apple-fonts-pkgs, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      
      systems = ["x86_64-linux"];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;

      settings = { pkgs, ... }@args: haumea.lib.load {
        src = ./settings;
        inputs = args // {
          inherit inputs;
          apple-fonts = apple-fonts-pkgs.packages.x86_64-linux;
        };
        transformer = haumea.lib.transformers.liftDefault;
      };
    in
    {
      inherit lib;

      nixosConfigurations = {
        desktop = lib.nixosSystem {
          modules = [
            settings
            ./desktop/nixos
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.admin = {
                imports = [ ./desktop/home.nix ];
              };
            }
          ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      #homeConfigurations = {
      #  "admin@desktop" = lib.homeManagerConfiguration {
          #modules = [
          #  ./desktop/home.nix
          #];
      #    pkgs = pkgsFor.x86_64-linux;
      #    extraSpecialArgs = { inherit inputs outputs; };
      #  };
      #};
    };
}
