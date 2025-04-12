{ config, lib, npins, ... }:
{
  imports = [
    "${npins.nixos-facter-modules}/modules/nixos/facter.nix"
  ];
  config = lib.mkIf config.tob.panel.enable {
    facter.reportPath = ./facter.json;
  };
}
