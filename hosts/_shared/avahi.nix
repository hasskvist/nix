{ lib, config, ... }:
let
  # Name of module. Config will be available at config.tob.${modname}
  modName = "avahi";
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
    services.avahi = {
      nssmdns4 = true;
      enable = true;
      ipv4 = true;
      ipv6 = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };
    systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
  };
}
