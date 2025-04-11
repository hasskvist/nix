{
  lib,
  config,
  pkgs,
  ...
}:
let
  modName = "fonts";
  cfg = config.tob.${modName};
in
{
  options.tob.${modName} = {
    enable = lib.mkOption {
      default = config.tob.gui.enable;
      description = "Whether to enable ${modName}.";
    };
  };
  config = lib.mkIf cfg.enable {
    system.fsPackages = [ pkgs.bindfs ];

    fileSystems =
      let
        mkRoSymBind = path: {
          device = path;
          fsType = "fuse.bindfs";
          options = [
            "ro"
            "resolve-symlinks"
            "x-gvfs-hide"
          ];
        };
        aggregated = pkgs.buildEnv {
          name = "system-fonts-and-icons";
          paths =
            config.fonts.packages
            ++ (with pkgs; [
              # Add your cursor themes and icon packages here
            ]);
          pathsToLink = [
            "/share/fonts"
            "/share/icons"
          ];
        };
      in
      {
        "/usr/share/fonts" = mkRoSymBind "${aggregated}/share/fonts";
        "/usr/share/icons" = mkRoSymBind "${aggregated}/share/icons";
      };
    fonts = {
      # Install a bunch of default fonts
      enableDefaultPackages = true;

      # Symlink fonts to a known font folder
      fontDir.enable = true;

      # Install Hack nerdfont
      packages = [
        pkgs.nerd-fonts.hack
        pkgs.noto-fonts
        pkgs.noto-fonts-emoji
        pkgs.noto-fonts-cjk-sans
      ];
    };
  };
}
