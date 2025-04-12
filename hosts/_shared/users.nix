{ config, pkgs, ... }:
let
  # hashed login password
  # generate with "mkpasswd -m bcrypt"
  hashedPassword = "$2b$05$UV9X2REQDqC0l6Bul5HMIOZ9SaQldn3NAnS854XE58klpgaYdofga";
in
{
  users.mutableUsers = false;
  users.users = {
    root = {
      inherit hashedPassword;
    };
    tobias = {
      inherit hashedPassword;
      # Run user units on startup
      linger = true;
      # Not a system user
      isNormalUser = true;
      # Beautiful name
      description = "Tobias";
      # Groups, to get permissions to do some things without privilege escalation
      extraGroups = [
        "networkmanager"
        "wheel"
        "pipewire"
      ];
      # Use FISH shell instead of bash
      shell = config.programs.fish.package;
      # Packages to add to the user (before home-manager)
      packages = with pkgs; [
        kdePackages.kate # Text editor
        google-chrome # Shitty web-browser
      ];
    };
  };
  # Configure user/home config for user(s)
  home-manager = {
    # If a file exists that home-manager wants to write to we rename the existing
    # one with .hbak as extension.
    backupFileExtension = "hbak";
    users.tobias =
      { pkgs, ... }:
      {
        # Import HM config
        imports = [ ../../home ];
        # Same stateversion in HM and nixos
        home.stateVersion = config.system.stateVersion;
      };
  };
}
