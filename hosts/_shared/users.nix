{ config, pkgs, ... }:
let
  hashedPassword = "$2b$05$UV9X2REQDqC0l6Bul5HMIOZ9SaQldn3NAnS854XE58klpgaYdofga";
in
{
  users.users = {
    root = {
      inherit hashedPassword;
    };
    tobias = {
      inherit hashedPassword;
      isNormalUser = true;
      description = "Tobias";
      extraGroups = [
        "networkmanager"
        "wheel"
        "pipewire"
      ];
      shell = config.programs.fish.package;
      packages = with pkgs; [
        kdePackages.kate # Text editor
        google-chrome # Shitty web-browser
      ];
    };
  };
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
