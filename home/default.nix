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

    programs.bash.enable = true;
    programs.fish = {
      enable = true;
      package = nixosConfig.programs.fish.package;
    };
    programs.bat.enable = true;
    programs.ripgrep.enable = true;
    programs.direnv.enable = true;
    programs.tealdeer = {
      enable = true;
      enableAutoUpdates = true;
    };
    programs.lsd = {
      enable = true;
      enableAliases = true;
    };
    programs.git = {
      enable = true;
    };
    programs.gitui.enable = true;
    programs.fd.enable = true;
    xdg = {
      enable = true;
      #portal.enable = true;
      userDirs.enable = true;
    };
  };
}
