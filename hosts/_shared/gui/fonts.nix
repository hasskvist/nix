{ lib, config, pkgs, ... }:
let
  modName = "fonts";
  cfg = config.tob.${modName};
in
{
  options.tob.${modName} = {
    enable = lib.mkOption {
      default = config.tob.gui.enable;
      description = "Whether to enable ${modName}.";
    };
  };
  config = lib.mkIf cfg.enable {
    fonts = {
      # Install a bunch of default fonts
      enableDefaultPackages = true;

      # Symlink fonts to a known font folder
      fontDir.enable = true;

      # Install Hack nerdfont
      packages = [ pkgs.nerd-fonts.hack ];
    };
  };
}
