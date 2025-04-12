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
    ./template.nix
  ];
  options.tob = {
    gui.enable = lib.options.mkEnableOption "gui";
  };
  config = {
    # Inherit GUI option from NixOS
    tob.gui.enable = nixosConfig.tob.gui.enable;

    # Installs packages into your user
    home.packages = with pkgs; [
      wl-clipboard-rs # Allow copying to clipboard from terminal
      nil # Nix Language Server
      nixfmt-rfc-style # Nix code formatter
      tmate # tmux fork for sharing terminal sessions
      home-assistant-cli # CLI tool for home-assistant
      htop # Task manager
      btop # Other task manager
      fastfetch # System info tool
    ];
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
