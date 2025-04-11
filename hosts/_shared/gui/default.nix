{ config, lib, ... }:
{
  imports = [
    ./kde.nix
    ./template.nix
  ];
  config = lib.mkIf config.tob.gui.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Fix XDG desktop portals
    environment.pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];

    services.flatpak.enable = true;
    xdg.portal.enable = true;

    programs.firefox.enable = true; # Install Firefox
    programs.virt-manager.enable = true; # Install virt-manager with SUID wrappers
  };
}
