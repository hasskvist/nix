{ lib, config, ... }:
let
  modName = "firewall";
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
    # Enable firewall, example for how to open ports
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        #22
      ];
      allowedUDPPorts = [
        #22
      ];
    };
  };
}
