{ lib, config, ... }:
let
  # Name of module. Config will be available at config.tob.${modname}
  modName = "sudo";
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
    security.sudo = {
      enable = true;

      # Make sudo swear
      extraConfig = ''
        Defaults insults
        Defaults pwfeedback
        Defaults:%wheel env_keep += "XDG_RUNTIME_DIR"
        Defaults:%wheel env_keep += "PATH"
      '';
      extraRules = [
        {
          users = [ "tobias" ];
          commands = [
            {
              command = "/run/current-system/sw/bin/nixos-rebuild";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
  };
}
