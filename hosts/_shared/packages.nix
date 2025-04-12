{
  lib,
  config,
  pkgs,
  ...
}:
let
  # Name of module. Config will be available at config.tob.${modname}
  modName = "packages";
  cfg = config.tob.${modName};
in
{
  options.tob.${modName} = {
    enable = lib.mkOption {
      default = true;
      description = "Whether to enable ${modName}.";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (pkgs.writeScriptBin "rebuild" ''
        #! ${pkgs.runtimeShell}
        sudo echo "sudoing"
        nixos-rebuild switch --file /etc/nixos/nixos.nix --use-remote-sudo
      '')
    ];
  };
}
