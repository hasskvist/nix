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
      # Runs pipewire under pipewire user
      # pipewire pulseaudio socket will be available at $PULSE_SERVER
      # (/run/pulse/native) rather than (/run/user/1000/pulse/native)
      systemWide = true;
    };
    # Configure PULSE_SERVER for shell environments
    environment.variables = { inherit PULSE_SERVER; };
    # Configure PULSE_SERVER for systemd units
    systemd.globalEnvironment = { inherit PULSE_SERVER; };
  };
}
