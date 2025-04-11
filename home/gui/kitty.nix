{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.tob.gui.enable {
    programs.kitty = {
      enable = true;
    };
  };
}
