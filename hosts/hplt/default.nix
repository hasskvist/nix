# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  lib,
  pkgs,
  npins,
  ...
}:
{
  imports = [
    ./libinput.nix
    ./facter.nix
    ./hardware-configuration.nix # Include the results of the hardware scan.
  ];
  config = lib.mkIf config.tob.hplt.enable {
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.networkmanager.enable = true;

    # Enable esphome to make firmware for ESP32
    services.esphome.enable = true;
    # Enable iio for screen rotation
    hardware.sensor.iio.enable = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?
  };
}
