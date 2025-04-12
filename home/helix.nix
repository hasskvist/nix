{ lib, config, pkgs, ... }:
let
  modName = "helix";
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
    programs.helix = {
      enable = true;
      languages = {
        language-server.nil = {
          config = {
            nil = {
              formatting.command = [ (lib.getExe pkgs.nixfmt-rfc-style) ];
            };
          };
        };
      };
    };
  };
}
