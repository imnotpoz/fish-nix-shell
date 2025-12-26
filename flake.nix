{
  description = "Fish support for the nix-shell environment of the Nix package manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, systems }: let
    forEachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    packages = forEachSystem (system: {
      fish-nix-shell = nixpkgs.legacyPackages.${system}.callPackage ./. {};
      default = self.packages.${system}.fish-nix-shell;
    });
  };
}
