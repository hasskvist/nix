{ lib, config, ... }:
let
  # Name of module. Config will be available at config.tob.${modname}
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
    # Example configuration
    lib.${modName} = {
      info = "Template module is enabled";
    };
  };
}
