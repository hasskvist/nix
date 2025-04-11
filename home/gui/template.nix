{ lib, config, ... }:
let
  modName = "guitemplate";
  cfg = config.tob.${modName};
in
{
  options.tob.${modName} = {
    enable = lib.mkOption {
      default = config.tob.gui.enable;
      description = "Whether to enable ${modName}.";
    };
  };
  config = lib.mkIf cfg.enable {
    lib.${modName} = {
      info = "Template module is enabled";
    };
  };
}
