let
  nixos = import ./configuration.nix;
  home = nixos.config.home-manager.users.tobias;
in
nixos
// {
  inherit home;
}
