{
  config,
  nixosConfig,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  config = {
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
      npins # nix dependency pinning tool
      lsof
      pulsemixer # Good tui pulse tool
      qpwgraph # pipewire patch-bay
      udiskie # GUI tool for udisks2
      nmap # Network scanning tool
      stremio # Media streaming suite
    ];
  };
}
