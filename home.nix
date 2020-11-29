{ config, pkgs, lib, ... }:

let
  # Import other Nix files
  imports = [
    ./git.nix
    ./neovim.nix
    ./fish.nix
    ./tmux.nix
    ./vscode.nix
  ];

  # Handly shell command to view the dependency tree of Nix packages
  depends = pkgs.writeScriptBin "depends" ''
    dep=$1
    nix-store --query --requisites $(which $dep)
  '';


  git-hash = pkgs.writeScriptBin "git-hash" ''
    nix-prefetch-url --unpack https://github.com/$1/$2/archive/$3.tar.gz
  '';

  wo = pkgs.writeScriptBin "wo" ''
    readlink $(which $1)
  '';

  run = pkgs.writeScriptBin "run" ''
    nix-shell --pure --run "$@"
  '';

  hugoLocal = pkgs.callPackage ./hugo.nix {
    hugoVersion = "0.74.3";
    sha = "0rikr4yrjvmrv8smvr8jdbcjqwf61y369wn875iywrj63pyr74r9";
    vendorSha = "031k8bvca1pb1naw922vg5h95gnwp76dii1cjcs0b1qj93isdibk";
  };

  scripts = [
    depends
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
  programs.direnv.enable = true;
  programs.direnv.enableNixDirenvIntegration = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pritamkadam";
  home.homeDirectory = "/Users/pritamkadam";

  home.sessionVariables = {
    PGDATA = "/usr/local/var/postgres";
    JAVA_HOME = "$(/usr/libexec/java_home -v 11)";
    PATH = "$PATH:/Users/pritamkadam/Library/Application Support/Coursier/bin";
    EDITOR = "code";
  };

  # Miscellaneous packages (in alphabetical order)
  home.packages = with pkgs; [
    coursier
    colorls
    pstree
    bash # /bin/bash
    bat # cat replacement written in Rust
    cachix # Nix build cache
    curl # An old classic
    direnv # Per-directory environment variables
    fzf # Fuzzy finder
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
    nodejs # node and npm
    pre-commit # Pre-commit CI hook tool
    python3 # Have you upgraded yet???
    ripgrep # grep replacement written in Rust
    spotify-tui # Spotify interface for the CLI
    tokei # Handy tool to see lines of code by language
    tree # Should be included in macOS but it's not
    vagrant # Virtualization made easy
    vscode # My fav text editor if I'm being honest
    slack
    wget
    yarn # Node.js package manager
    youtube-dl # Download videos
    nixpkgs-fmt
    cacert
    nix
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
