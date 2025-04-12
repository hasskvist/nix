{ config, lib, npins, ... }:
{
  imports = [
    "${npins.nixos-facter-modules}/modules/nixos/facter.nix"
  ];

  config.facter.reportPath = ./facter.json;
}
