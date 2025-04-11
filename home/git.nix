{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Tobbelito";
    userEmail = "tobbe@flipperspel.nu";

    extraConfig = {
      advice.diverging = false;
      branch.sort = "-committerdate";
      column.ui = "auto";
      core.fsmonitor = true;
      core.ignorecase = false;
      core.untrackedcache = true;
      fetch.recurseSubmodules = true;
      init.defaultBranch = "main";
      pull.ff = "only";
      push.autoSetupRemote = true;
      rebase.autoStash = true;
      rebase.updateRefs = true;
      rerere.enable = true;
      tag.sort = "version:refname";
      trim.bases = "master,main,develop";
      safe.directory = [ "/etc/nixos" ];
    };
  };
}
