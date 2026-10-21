{
  description = "NixOS (t480) and macOS (macbook) sharing one home-manager config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # Makes Nix-installed GUI apps visible to Spotlight (macOS only).
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Newer Claude Code releases than nixpkgs.
    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs = inputs@{ nixpkgs, home-manager, nix-darwin, ... }:
    let
      # Applied identically to both hosts.
      common = {
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = [
          (import ./pkgs)
          inputs.claude-code.overlays.default
        ];
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
        };
      };
    in
    {
      nixosConfigurations.t480 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          common
          ./hosts/t480
        ];
      };

      darwinConfigurations.macbook = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.darwinModules.home-manager
          inputs.mac-app-util.darwinModules.default
          { home-manager.sharedModules = [ inputs.mac-app-util.homeManagerModules.default ]; }
          common
          ./hosts/macbook
        ];
      };
    };
}
