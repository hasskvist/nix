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
#### How to configure shit?
If you're configuring something that applies to all machines you copy hosts/_shared/template.nix to hosts/_shared/modulename.nix where modulename is a descriptive name of what you're configuring. Once copied you must import it i hosts/_shared/default.nix.

If you want to configure GUI config to apply to all machines that has a GUI, the same applies but for hosts/_shared/gui.

The same ruleset also applies to home/template.nix, home/gui/template.nix etc...

Once you have the template, remove everything in the config block and add your own configuration, options can be found at https://search.nixos.org/packages?channel=unstable

Using the NixOS module system makes configuration composable, so try to not take shortcuts :))
