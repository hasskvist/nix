{
  config,
  nixosConfig,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    ./gui
    ./git.nix
    ./neovim.nix
    ./helix.nix
    ./packages.nix
    ./template.nix
  ];
  options.tob = {
    gui.enable = lib.options.mkEnableOption "gui";
  };
  config = {
    # Inherit GUI option from NixOS
    tob.gui.enable = nixosConfig.tob.gui.enable;

    # Enable HM bash config
    programs.bash.enable = true;

    # Enable HM fish config
    programs.fish = {
      enable = true;
      # Use same fish package as configured in NixOS
      package = nixosConfig.programs.fish.package;
    };

    # Enable bat, a modern cat alternative
    programs.bat.enable = true;

    # Enable ripgrep(rg), a modern grep alternative
    programs.ripgrep.enable = true;

    # Enable direnv (Executes shell scripts when you enter directories)
    programs.direnv.enable = true;

    # Enable tealdeer (command: tldr to find common CLI usage)
    programs.tealdeer = {
      enable = true;
      enableAutoUpdates = true;
    };

    # Enable LSD, a modern ls alternative
    programs.lsd.enable = true;

    # Enable git
    programs.git = {
      enable = true;
    };

    # Enable gitui, a nice git TUI
    programs.gitui.enable = true;

    # Enable fd, a modern find alternative
    programs.fd.enable = true;

    # Configure XDG
    xdg = {
      enable = true;
      # Create XDG directories if they don't exist
      userDirs.enable = true;
    };
  };
}
