{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.tob;
in
{
  imports = [
    ./gui
    ./users.nix
  ];
  options.tob = {
    gui.enable = lib.options.mkEnableOption "gui";
  };
  config = {
  };
}
