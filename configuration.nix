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
    (
      if hostname == "hplt" then
        # Import hplt (hp laptop) modules
        [
          ./hosts/hplt
          {
            # Enable gui config
            tob.gui.enable = true;
          }
        ]
      else if hostname == "panel" then
        [
          # Import panel (broken dell touch) modules
          ./hosts/panel
          {
            # Enable gui config
            tob.gui.enable = true;
          }
        ]
      else
        # If HOSTNAME isn't hplt or panel we error out
        builtins.throw "environment variable HOSTNAME must be set"
    )
    ++ [
      # Import shared modules
      ./hosts/_shared
    ];
}
