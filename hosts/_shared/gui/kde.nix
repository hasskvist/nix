{ lib, pkgs, config, ... }:
let
  modName = "kde";
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
    # Disable X11, we are Wayland.
    services.xserver.enable = false;
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    services.displayManager.sddm.settings.General.DisplayServer = "wayland";
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      elisa
    ];
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "se";
      variant = "";
    };
  };
}
