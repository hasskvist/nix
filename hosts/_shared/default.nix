{
  config,
  pkgs,
  lib,
  npins,
  ...
}:
let
  cfg = config.tob;
in
{
  imports = [
    ./gui
    ./avahi.nix
    ./users.nix
    ./locale.nix
    ./firewall.nix
    ./nix.nix
    ./template.nix
    ./sudo.nix
    ./spotify.nix
    ./pipewire.nix
    ./packages.nix
    (import npins.home-manager {}).nixos
  ];

  options.tob = {
    gui.enable = lib.options.mkEnableOption "gui";
    hplt.enable = lib.options.mkEnableOption "hplt";
    panel.enable = lib.options.mkEnableOption "panel";
  };

  config = {
    # Use same nixpkgs instance for home-manager
    home-manager.useGlobalPkgs = true;

    # Install home-manager profiles in /etc/profiles
    home-manager.useUserPackages = true;

    # Don't install the /lib/ld-linux.so.2 stub. This saves one instance of nixpkgs (maybe?)
    environment.ldso32 = null;

    # This installs a lot of terminals
    environment.enableAllTerminfo = true;

    system.nixos.label = "unstable";

    # Use latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Enable sysstat logging
    services.sysstat.enable = true;

    # Enable fstrim. TRIM zeroes out unused blocks on your SSD which helps
    # the wear-leveling feature keep your SSD alive.
    services.fstrim.enable = true;

    # Enable nix-ld, a magical runtime linker
    programs.nix-ld.enable = true;

    # FS that returns symlinks from FHS to nix store using magic and pixie dust
    services.envfs.enable = true;

    # Enable firmware update utility
    services.fwupd.enable = true;

    # Configure earlyoom service that kills processes when we need to
    # reclaim memory (RAM) in case we run out of it.
    services.earlyoom = {
      enable = true;
      enableNotifications = true;
    };

    # Get notifications from the system bus
    services.systembus-notify.enable = true;

    # Enable fish shell so we can use it as login shell
    programs.fish.enable = true;

    # Enable iotop so we can monitor disk IO
    programs.iotop.enable = true;

    # Configure usbguard
    # We allow all devices, but having usbguard running is a NiceToHave
    services.usbguard = {
      enable = true;
      dbus.enable = true;
      implicitPolicyTarget = "allow";
      IPCAllowedUsers = [ "tobias" ];
      IPCAllowedGroups = [ "wheel" ];
    };

    # Enable udisks service, this allows you to manage external disks through
    # GUI applications easily.
    services.udisks2.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    # Or browse to https://search.nixos.org/packages?channel=unstable
    environment.systemPackages = with pkgs; [
      # Enter package names here
      dmidecode # hardware info
      waypipe # wayland over SSH
    ];

    # Enable mtr for tracerouting, this configures a SUID wrapper for mtr
    programs.mtr.enable = true;

    # Enable gnupg agent
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      openFirewall = true; # Opens the SSH port in firewall
      settings = {
        X11Forwarding = true;
      };
    };

    hardware.flipperzero.enable = true;
  };
}
