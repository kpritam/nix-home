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
  l = "exa -lahG";
  ls = "colorls";
  la = "ls -lah";
  md = "mkdir -p";
  cx = "chmod +x";
  cat = "bat";
  #  Jump to projects
  D = "cd ~/Downloads";
  p = "cd ~/projects";
  tmt = "cd ~/projects/tmtsoftware";
  my = "cd ~/projects/kpritam";
  csw = "cd ~/projects/tmtsoftware/csw";
  esw = "cd ~/projects/tmtsoftware/esw";
  #  git
  root = "cd (git rev-parse --show-cdup)";
  gpom = "git push origin master";
  gpr = "git pull --rebase";

  localip = "ipconfig getifaddr en0";
}