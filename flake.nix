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
        packages = {
          beamdogClient = pkgs.callPackage ./overlays/beamdogClient { };
          cataclysm-dda = pkgs.callPackage ./overlays/cataclysm-dda { };
          fjordlauncher = pkgs.callPackage ./overlays/fjordlauncher { };
          wlx-overlay-s = pkgs.callPackage ./overlays/wlx-overlay-s { };
          OpenAudible = pkgs.callPackage ./overlays/OpenAudible { };
        };
        apps = rec {
          beamdogClient = {
            type = "app";
            program = "${self.packages.${system}.beamdogClient}/bin/beamdogClient";
          };
          cataclysm-dda = {
            type = "app";
            program = "${self.packages.${system}.cataclysm-dda}/bin/cataclysm-tiles";
          };
          fjordlauncher = {
            type = "app";
            program = "${self.packages.${system}.fjordlauncher}/bin/fjordlauncher";
          };
          OpenAudible = {
            type = "app";
            program = "${self.packages.${system}.OpenAudible}/bin/OpenAudible";
          };
          wlx-overlay-s = {
            type = "app";
            program = "${self.packages.${system}.wlx-overlay-s}/bin/wlx-overlay-s";
          };
        };
      }
    );
}
