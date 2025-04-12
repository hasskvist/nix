{ lib, config, ... }:
let
  # Name of module. Config will be available at config.tob.${modname}
  modName = "pipewire";
  cfg = config.tob.${modName};
  PULSE_SERVER = "unix:/run/pulse/native";
in
{
  options.tob.${modName} = {
    enable = lib.mkOption {
      default = true;
      description = "Whether to enable ${modName}.";
    };
  };
  config = lib.mkIf cfg.enable {
    # Enable sound with pipewire.
    services.pulseaudio.enable = false;

    # Enable realtime processing
    security.rtkit.enable = true;

    # Configure pipewire audio server
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      socketActivation = true;
      systemWide = true;
    };
    environment.variables = { inherit PULSE_SERVER; };
    environment.sessionVariables = { inherit PULSE_SERVER; };
  };
}
