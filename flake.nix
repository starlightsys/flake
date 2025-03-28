{
  description = "runme application";

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
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.writeShellScriptBin "runme" ''
          echo "I am currently being run!"
        '';
        apps = rec {
          default = runme;
          runme = {
            type = "app";
            program = "${self.packages.${system}.default}/bin/runme";
          };
        };
      }
    );
}
