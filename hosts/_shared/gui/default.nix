{ config, lib, ... }:
{
  imports = [
    ./kde.nix
    ./fonts.nix
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

    # Enable flatpaks
    services.flatpak.enable = true;

    # Enable XDG portals
    xdg.portal.enable = true;

    # Enable Firefox
    programs.firefox.enable = true;

    # Enable virt-manager
    programs.virt-manager.enable = true;

    # Enable uinput, if we want to do remapping
    hardware.uinput.enable = true;
  };
}
