{ config, pkgs, ... }:
{
  users.users.tobias = {
    isNormalUser = true;
    description = "Tobias";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = config.programs.fish.package;
    packages = with pkgs; [
      kdePackages.kate # Text editor
      google-chrome # Shitty web-browser
    ];
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
