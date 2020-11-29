# Shell configuration for zsh (frequently used) and fish (used just for fun)

{ config, lib, pkgs, ... }:

let

  themeConfig = ''
    set -g theme_nerd_fonts yes
    set -g theme_display_git_dirty yes
    set -g theme_git_default_branches master main
    set -g theme_display_git_master_branch yes
    set -g theme_color_scheme dracula
  '';

  # Set all shell aliases programatically
  shellAliases = {
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
    ls = "colorls";
    la = "ls -ahl";
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

  };
in {
  # fish shell settings
  programs.fish = {
    inherit shellAliases;
    enable = true;
    
    promptInit = ''
      eval (direnv hook fish)
      any-nix-shell fish --info-right | source
    '';

    plugins = [
      {
        name = "colored-man";
        src = pkgs.fetchFromGitHub {
          owner = "decors";
          repo = "fish-colored-man";
          rev = "c1e9db7765c932587b795d6c8965e9cff2fd849a";
          sha256 = "0kpivdnynmkb9h824lh1z4djsjniaqdwfv0mjjia2rbpzvn8pca1";
        };
      }

      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "13a320bee8b815704772d94f5994745b11cd1e03";
          sha256 = "0z7l7fgd9khcq1fi9ymjjrxj58pw5xdzg8k6mxqmqw1345hkpr4f";
        };
      }

      {
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "df4a1ebf8c0536e4bd7b7828a4c0dcb2b7b5d22b";
          sha256 = "1dgydrza6lvx3dl9spkla1g728x5rr76mqrwk2afrl732439y6jl";
        };
      }

      {
        name = "foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
          sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
        };
      }

      {
        name = "bobthefish";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "theme-bobthefish";
          rev = "f3ec01dd10f7311821302b4747d82fceb7c15587";
          sha256 = "0kpivdnynmkb9h824lh1z4djsjniaqdwfv0mjjia2rbpzvn8pca1";
        };
      }
    ];

    shellInit = themeConfig;
    loginShellInit = ''
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end

      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix.sh
        fenv source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      end

      if test -e ~/.nix-profile/etc/profile.d/nix.sh
        fenv source ~/.nix-profile/etc/profile.d/nix.sh
      end

      set -x LESS_TERMCAP_mb (printf '\e[1;31m')     # begin bold
      set -x LESS_TERMCAP_md (printf '\e[1;33m')     # begin blink
      set -x LESS_TERMCAP_so (printf '\e[01;44;37m') # begin reverse video
      set -x LESS_TERMCAP_us (printf '\e[01;37m')    # begin underline
      set -x LESS_TERMCAP_me (printf '\e[0m')        # reset bold/blink
      set -x LESS_TERMCAP_se (printf '\e[0m')        # reset reverse video
      set -x LESS_TERMCAP_ue (printf '\e[0m')        # reset underline
      set -x GROFF_NO_SGR 1                  # for konsole and gnome-terminal
    '';
  };

  xdg.configFile."fish/conf.d/plugin-bobthefish.fish".text = lib.mkAfter ''
    for f in $plugin_dir/*.fish
      source $f
    end
  '';

}
