{
  config,
  pkgs,
  lib,
  ...
}:
let
  # When running nixos-install or nixos-rebuild HOSTNAME
  # must be set manually the first time(until HOSTNAME is in all your shells)
  hostname = lib.trim (builtins.getEnv "HOSTNAME");
in
{
  # Set hostname based on HOSTNAME environment variable
  networking.hostName = hostname;

  # Set HOSTNAME variable s
  environment.variables = {
    HOSTNAME = config.networking.hostName;
  };

  imports =
    if hostname == "hplt" then
      [
        ./hosts/hplt
      ]
    else if hostname == "panel" then
      [
        ./hosts/panel
      ]
      ++ [
        # shared modules
      ]
    else
      builtins.throw "environment variable HOSTNAME must be set";
}
