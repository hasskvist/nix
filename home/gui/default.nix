{ config, lib, ... }:
{
  imports = [
    ./kitty.nix
  ];
  config = lib.mkIf config.tob.gui.enable {
  };
}
