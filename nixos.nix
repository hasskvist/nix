let
  system = builtins.currentSystem;
  npins = import ./npins;
  eval-config = import "${npins.nixos-unstable}/nixos/lib/eval-config.nix";
  pkgs = import npins.nixos-unstable {
    inherit system;
    config.allowUnfree = true;
    overlays = [ ];
  };
  lib = pkgs.lib;
  # When running nixos-install or nixos-rebuild HOSTNAME
  # must be set manually the first time(until HOSTNAME is in all your shells)
  hostname = lib.trim (builtins.getEnv "HOSTNAME");
in
eval-config {
  inherit pkgs system;
  specialArgs = {
    inherit npins;
  };
  modules =
    (
      if hostname == "hplt" then
        # Import hplt (hp laptop) modules
        [
          ./hosts/hplt
          {
            # Enable gui config
            tob.gui.enable = true;
            # Enable hplt specific config
            tob.hplt.enable = true;
          }
        ]
      else if hostname == "panel" then
        [
          # Import panel (broken dell touch) modules
          ./hosts/panel
          {
            # Enable gui config
            tob.gui.enable = true;
            lib.npins = npins;
          }
        ]
      else
        # If HOSTNAME isn't hplt or panel we error out
        builtins.throw "environment variable HOSTNAME must be set"
    )
    ++ [
      # Import shared modules
      ./hosts/_shared
      #./sources.nix
      {
        # Set hostname based on HOSTNAME environment variable
        networking.hostName = hostname;

        # Set HOSTNAME variable s
        environment.variables = {
          HOSTNAME = hostname;
        };
      }
    ];
}
