# SPDX-FileCopyrightText: 2021 Kirill Elagin <https://kir.elagin.me/>
#
# SPDX-License-Identifier: MIT

{
  description = "Nix DSL for defining DNS zones";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      inherit (nixpkgs) lib;
      dns = import ./dns { inherit lib; };
    in {

      lib = {
        inherit (dns) evalZone;
        inherit (dns) combinators;
        toString = name: zone: builtins.toString (dns.evalZone name zone);
      } // dns.combinators;

    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        util = {
          writeZone = import ./util/writeZone.nix {
            inherit (self.lib) evalZone;
            inherit (pkgs) writeTextFile;
          };
        };
      }
    );
}
