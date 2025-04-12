{ lib, config, ... }:
let
  # Name of module. Config will be available at config.tob.${modname}
  modName = "libinput";
  cfg = config.tob.${modName};
in
{
  options.tob.${modName} = {
    enable = lib.mkOption {
      default = config.tob.hplt.enable;
      description = "Whether to enable ${modName}.";
    };
  };
  config = lib.mkIf cfg.enable {
    # Configure libinput input config
    services.libinput = {
      # Enable
      enable = true;
      # Use natural scrolling (matches touch-screen scrolling)
      touchpad.naturalScrolling = true;
    };
  };
}
