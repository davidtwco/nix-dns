#
# © 2019 Kirill Elagin <kirelagin@gmail.com>
#
# SPDX-License-Identifier: MIT
#

{ lib }:

let
  inherit (lib) mkOption types;

in

{
  rtype = "TXT";
  options = {
    data = mkOption {
      type = types.str;
      example = "favorite drink=orange juice";
      description = "Arbitrary information";
    };
  };
  dataToString = {data, ...}: ''"${data}"'';
  fromString = data: { inherit data; };
}
