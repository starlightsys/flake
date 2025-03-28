{
  pkgs,
  lib,
  cataclysmDDA,
  ...
}:
let
  patchedCDDA =
    (cataclysmDDA.git.tiles.override {
      version = "2024-12-26-0350";
      rev = "7ba4c09a5cfa479ac89945a117e60b24be8a4e03";
      sha256 = "sha256-aDQI3V9Pzky2/KmixqsKx66+AI1itquaYF4ytUfjUuk=";
    }).overrideAttrs
      (oldAttrs: {
        patches = [
          ./patches/locale-path.patch
          ./patches/no-whining.patch
        ];
      });
  customMods =
    self: super:
    lib.recursiveUpdate super {
      mod.No_Roaches = pkgs.cataclysmDDA.buildMod {
        modName = "No_Roaches";
        version = "0.1.2";
        src = pkgs.fetchFromGitHub {
          owner = "starlightsys";
          repo = "No_Roaches";
          rev = "a8fbb6d0bcdea7dd5a5e552fa383aa3396c1f793";
          hash = "sha256-EsF4wT3irvJ1AnDVkx8pEkrdkPhxtncgBTEgTQ7jckQ=";
        };
      };
    };
  myCDDA =
    let
      inherit (cataclysmDDA) attachPkgs pkgs;
    in
    (attachPkgs pkgs patchedCDDA).withMods (
      mods:
      (with mods; [
        # tileset.UndeadPeople
      ])
      ++ (with mods.extend customMods; [
        mod.No_Roaches
      ])
    );
in
myCDDA
