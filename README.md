# Tobbe NixOS configuration
This repository contains Nix(OS+home-manager...) configuration for various machines in my smart home

## nixos-rebuild
We're staying away from flakes currently since all they bring is Nix evaluation from Nix store.
Our nixos entrypoint is "configuration.nix" where we read the environment variable HOSTNAME to decide which modules to import.

If HOSTNAME isn't configured we will error out, once we have configured the system once HOSTNAME will be configured
in the system variables and set by default (You only need to do this on initial installation).

### How to use:
```
nixos-rebuild switch --use-remote-sudo
```


