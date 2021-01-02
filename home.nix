{ config, pkgs, lib, ... }:

let
  # Import other Nix files
  imports = [
    ./git.nix
    ./neovim/default.nix
    ./fish/default.nix
    ./tmux.nix
    # ./vscode.nix
  ];

  # Handly shell command to view the dependency tree of Nix packages
  dtree = pkgs.writeScriptBin "dtree" ''
    #!${pkgs.bash}/bin/bash
    dep=$1
    nix-store --query --requisites $(which $dep)
  '';

  dgraph = pkgs.writeScriptBin "dgraph" ''
    #!${pkgs.bash}/bin/bash
    dep=$1
    nix-store --query --graph $(which $dep) | dot -Tpdf > /tmp/graph.pdf && open /tmp/graph.pdf
  '';


  git-hash = pkgs.writeScriptBin "git-hash" ''
    #!${pkgs.bash}/bin/bash
    nix-prefetch-url --unpack https://github.com/$1/$2/archive/$3.tar.gz
  '';

  wo = pkgs.writeScriptBin "wo" ''
    #!${pkgs.bash}/bin/bash
    readlink $(which $1)
  '';

  run = pkgs.writeScriptBin "run" ''
    #!${pkgs.bash}/bin/bash
    nix-shell --pure --run "$@"
  '';

  hugoLocal = pkgs.callPackage ./hugo.nix {
    hugoVersion = "0.74.3";
    sha = "0rikr4yrjvmrv8smvr8jdbcjqwf61y369wn875iywrj63pyr74r9";
    vendorSha = "031k8bvca1pb1naw922vg5h95gnwp76dii1cjcs0b1qj93isdibk";
  };

  scripts = [
    dtree
    dgraph
    git-hash
    run
    wo
  ];

  gitTools = with pkgs.gitAndTools; [
    delta
    diff-so-fancy
    git-codeowners
    gitflow
    gh
  ];

in {
  inherit imports;

  # Allow non-free (as in beer) packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pritamkadam";
  home.homeDirectory = "/Users/pritamkadam";

  home.sessionVariables = {
    PGDATA = "/usr/local/var/postgres";
    JAVA_HOME = "$(/usr/libexec/java_home -v 11)";
    EDITOR = "nvim";
  };

  programs = {
    bat = {
      enable = true;
      config.theme = "Dracula";
    };

    broot = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
      enableNixDirenvIntegration = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    gpg.enable = true;

    htop = {
      enable = true;
      sortDescending = true;
      sortKey = "PERCENT_CPU";
    };

    jq.enable = true;
    ssh.enable = true;
  };

  # Miscellaneous packages (in alphabetical order)
  home.packages = with pkgs; [
    any-nix-shell  # fish support for nix shell
    coursier
    colorls
    pstree
    bash # /bin/bash
    bat # cat replacement written in Rust
    cachix # Nix build cache
    curl # An old classic
    direnv # Per-directory environment variables
    fzf # Fuzzy finder
    fd
    ranger
    gnupg # gpg
    pinentry_mac # Necessary for GPG
    gradle
    htop # Resource monitoring
    httpie # Like curl but more user friendly
    hugoLocal # Best static site generator ever
    jq # JSON parsing for the CLI
    jsonnet # Easy config language
    lorri # Easy Nix shell
    ngrok # Expose local HTTP stuff publicly
    niv # Nix dependency management
    nix-serve
    nixos-generators
    pre-commit # Pre-commit CI hook tool
    python3 # Have you upgraded yet???
    ripgrep # grep replacement written in Rust
    tokei # Handy tool to see lines of code by language
    tree # Should be included in macOS but it's not
    vagrant # Virtualization made easy
    # vscode # My fav text editor if I'm being honest
    slack
    wget
    yarn # Node.js package manager
    youtube-dl #Download videos
    tldr
    ncdu
    exa
    graphviz # Graph visualization tools
    ffmpeg
    rename

    neofetch # A fast, highly customizable system info script
    dive # A tool for exploring each layer in a docker image
    gotop # A terminal based graphical activity monitor inspired by gtop and vtop

    nixpkgs-fmt
    cacert
    # nix
  ] ++ gitTools ++ scripts;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
