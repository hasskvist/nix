{
  pkgs,
  lib,
  config,
  ...
}:
let
  # Name of module. Config will be available at config.tob.${modname}
  modName = "spotify";
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
    environment.systemPackages = [
      pkgs.spotifyd
    ];

    services.spotifyd = {
      enable = true;

      settings = {
        global = {
          bitrate = 320;
          device_name = config.networking.hostName;
          zeroconf_port = 59382;
          use_mpris = false;
          backend = "pulseaudio";
          #device = "pulse:server=/run/pulse/native";
        };
      };
    };
    systemd.services.spotifyd = {
      environment = {
        PULSE_SERVER = config.environment.variables.PULSE_SERVER;
      };
      serviceConfig = {
        DynamicUser = lib.mkForce false;
        User = "spotifyd";
      };
    };
    users.users.spotifyd = {
      isSystemUser = true;
      extraGroups = [ "pipewire" ];
      group = "spotifyd";
    };
    users.groups.spotifyd = {};
    networking.firewall.allowedTCPPorts = [
      57621
      59382
    ];
    networking.firewall.allowedUDPPorts = [ 5353 ];
  };
}
