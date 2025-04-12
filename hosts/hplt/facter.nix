{ config, lib, npins, ... }:
{
  imports = [
    "${npins.nixos-facter-modules}/modules/nixos/facter.nix"
  ];
  config = lib.mkIf config.tob.hplt.enable {
    facter.reportPath = ./facter.json;
  };
}
