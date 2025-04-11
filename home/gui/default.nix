{ config, lib, ... }:
{
  imports = [
    ./template.nix
    ./kitty.nix
  ];
  config = lib.mkIf config.tob.gui.enable {
  };
}
