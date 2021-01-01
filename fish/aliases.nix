{ pkgs, ... }:

{
  # Aliases for commonly used tools
  grep = "grep --color=auto";
  cloc = "tokei";
  dk = "docker";
  k = "kubectl";
  dc = "docker-compose";
  find = "fd";
  mk = "minikube";
  du   = "ncdu --color dark -rr -x";

  hm = "home-manager";
  hms = "home-manager switch";
  garbage = "nix-collect-garbage -d && docker image prune --force"; # Nix garbage collection
  hmu = "nix-channel --update && hms";

  # See which Nix packages are installed
  installed = "nix-env --query --installed";

  ".." = "cd ..";
  l = "${pkgs.exa}/bin/exa -lahG";
  ls = "${pkgs.colorls}/bin/colorls";
  lst = "${pkgs.colorls}/bin/colorls --tree";
  la = "${pkgs.colorls}/bin/colorls -lah";
  md = "mkdir -p";
  cx = "chmod +x";
  cat = "${pkgs.bat}/bin/bat";
  #  Jump to projects
  D = "cd ~/Downloads";
  p = "cd ~/projects";
  tmt = "cd ~/projects/tmtsoftware";
  my = "cd ~/projects/kpritam";
  csw = "cd ~/projects/tmtsoftware/csw";
  esw = "cd ~/projects/tmtsoftware/esw";
  #  git
  root = "cd (${pkgs.gitAndTools.git}/bin/git rev-parse --show-cdup)";
  gpom = "${pkgs.gitAndTools.git}/bin/git push origin master";
  gpr = "${pkgs.gitAndTools.git}/bin/git pull --rebase";
  g = "${pkgs.gitAndTools.git}/bin/git";

  c = "code-insiders";

  localip = "ipconfig getifaddr en0";
}