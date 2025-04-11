{ config, lib, ... }:
{
  imports = [
    <nixos-facter-modules/modules/nixos/facter.nix>
  ];

  config.facter.reportPath = ./facter.json;
}
