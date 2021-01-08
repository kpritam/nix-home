# Git settings

{ config, lib, pkgs, ... }:

let
  vscode = pkgs.vscode;
in {
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Pritam Kadam";
    userEmail = "kpritam@thoughtworks.com";

    # Replaces ~/.gitignore
    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      ".metals"
      "metals.sbt"
      ".bloop"
      "*.swp"
      "dumb.rdb"
      ".vscode/"
      "npm-debug.log"
      "shell.nix"
    ];

    # Replaces aliases in ~/.gitconfig
    aliases = {
      ba = "branch -a";
      bd = "branch -D";
      br = "branch";
      cam = "commit -am";
      co = "checkout";
      cob = "checkout -b";
      ci = "commit";
      cm = "commit -m";
      cp = "commit -p";
      d = "diff";
      dco = "commit -S --amend";
      s = "status";
      pr = "pull --rebase";
      pom = "push origin master";
      st = "status";
      l = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
      whoops = "reset --hard";
      wipe = "commit -s";
      fix = "rebase --exec 'git commit --amend --no-edit -S' -i origin/develop";
    };

    # Global Git config
    extraConfig = {
      core = {
        editor = "nvim";
        pager = "delta --dark";
        whitespace = "trailing-space,space-before-tab";
      };

      commit.gpgsign = "true";
      gpg.program = "gpg2";

      protocol.keybase.allow = "always";
      credential.helper = "osxkeychain";
      pull.rebase = "true";
    };
  };
}
