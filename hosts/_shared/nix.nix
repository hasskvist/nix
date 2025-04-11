{ lib, config, ... }:
let
  # Name of module. Config will be available at config.tob.${modname}
  modName = "nix";
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
    # Configure automatic upgrades
    system.autoUpgrade = {
      enable = true;
      allowReboot = true;
    };
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    nix = {
      # Enable nix command and flakes.
      # We don't use flakes right now but support for it is nice to have.
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
      optimise.automatic = true;
    };
  };
}
