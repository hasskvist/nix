let
  # Get system architecture
  system = builtins.currentSystem;
  # Get the function that's used to build a NixOS system
  eval-config = import <nixos/nixos/lib/eval-config.nix>;
in
# Call eval-config with current system
# Everything in our NixOS config goes through configuration.nix as entrypoint
eval-config {
  inherit system;
  modules = [
    ./configuration.nix
  ];
}
