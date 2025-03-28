{
  description = "App flake";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.fjordlauncher = pkgs.callPackage ./overlays/fjordlauncher { };
        apps = rec {
          fjordlauncher = {
            type = "app";
            program = "${self.packages.${system}.fjordlauncher}/bin/fjordlauncher";
          };
        };
      }
    );
}
