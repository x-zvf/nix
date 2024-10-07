{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nixvim = {
    #  url = "github:nix-community/nixvim";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    #flake-utils.url = "github:numtide/flake-utils";
    #    rust-overlay = {
    #      url = "github:oxalica/rust-overlay";
    #      inputs = {
    #        nixpkgs.follows = "nixpkgs";
    #        flake-utils.follows = "flake-utils";
    #      };
    #    };
  };

  outputs = {
    self,
    nixpkgs,
    #rust-overlay,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.users.xzvf = import ./home.nix;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
