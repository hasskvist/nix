# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  ethIfName = "enp55s0u2u4";
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
  ];

  services.vscode-server.enable = true;
  services.vscode-server.enableFHS = true;
  networking.useNetworkd = true;
  networking.bridges.br0.interfaces = [ ethIfName ];
  networking.interfaces.br0.useDHCP = true;
  networking.interfaces.${ethIfName}.useDHCP = true;
  networking.nameservers = [ "9.9.9.9" ];
  systemd.services.libvirt-guest.serviceConfig.RestartSec = "10s";
  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "* * * * *      root    virsh start hass"
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable libvirt for hosting virtual machines
  virtualisation.libvirtd.enable = true;

  # Disable all power-saveing states
  systemd.targets.suspend.enable = false;
  systemd.targets.sleep.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # Disable firewall
  networking.firewall.enable = false;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "tobias";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  #systemd.services."getty@tty1".enable = false;
  #systemd.services."autovt@tty1".enable = false;

  environment.systemPackages = with pkgs; [
    virt-manager
    waypipe
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
