{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.tob;
in
{
  imports = [
    ./gui
    ./users.nix
    ./locale.nix
    ./firewall.nix
    ./template.nix
    <home-manager/nixos> # import home-manager
  ];
  options.tob = {
    gui.enable = lib.options.mkEnableOption "gui";
  };
  config = {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Use latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    programs.fish = {
      enable = true;
    };

    security.sudo = {
      enable = true;
      extraConfig = ''
        Defaults insults
        Defaults pwfeedback
        Defaults:%wheel env_keep += "XDG_RUNTIME_DIR"
        Defaults:%wheel env_keep += "PATH"
      '';
    };

    services.usbguard = {
      enable = true;
      dbus.enable = true;
      implicitPolicyTarget = "allow";
      IPCAllowedUsers = [ "tobias" ];
      IPCAllowedGroups = [ "wheel" ];
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      # Enter package names here
      dmidecode
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      openFirewall = true; # Opens the SSH port in firewall
      settings = {
        X11Forwarding = true;
      };
    };
  };
}
