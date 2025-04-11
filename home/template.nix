{ lib, config, ... }:
let
  modName = "template";
  cfg = config.tob.${modName};
in
{
  options.tob.${modName} = {
    enable = lib.mkOption {
      default = true;
      description = "Whether to enable ${modName}.";
    };
  };
  config = lib.mkIf cfg.enable {
    lib.${modName} = {
      info = "Template module is enabled";
    };
  };
}
