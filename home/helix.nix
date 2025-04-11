{ lib, config, ... }:
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
    };
  };
}
