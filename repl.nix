let
  nixos = import ./nixos.nix;
  home = nixos.config.home-manager.users.tobias;
in
nixos
// {
  inherit home;
}
