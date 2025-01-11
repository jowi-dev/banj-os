{ config, pkgs, lib, currentSystem, fnord, banj-cli, ... }:
with lib;
let
  burn-to-iso = pkgs.callPackage ./pkgs/burn-to-iso { };
  logDirPersonal = "${currentSystem.directories.home}/log-dir";
  sitePersonal = "${currentSystem.directories.home}/sites/personal";
  #_1password = pkgs.callPackage ./pkgs/1password.nix { 
#    currentSystem = currentSystem;
#  };

in {
    imports = [ ./home/nvim ./home/git ./home/shell ./home/tmux ];
  	  config = {

    programs.home-manager.enable = true;

    home = with currentSystem.directories; {

      sessionVariables = {
        OPENAI_MODEL = "gpt-4-1106-preview";
        EDITOR = "nvim";
        CONFIG_DIR="${tooling}";
        FLAKE="${currentSystem.name}";
        LOG_DIR_PERSONAL=logDirPersonal;
        SITE_PERSONAL=sitePersonal;

      }; #// currentSystem.cmds;
      stateVersion = "23.11";
      username = currentSystem.user;
      file = currentSystem.extraConfigFiles;


    activation.cloneLogRepo = lib.hm.dag.entryAfter ["writeBoundary"] ''
      export PATH="${pkgs.openssh}/bin:$PATH"
      LOG_DIR="${logDirPersonal}";
      if [ ! -d "$LOG_DIR" ]; then
        $DRY_RUN_CMD mkdir -p "$(dirname "$LOG_DIR")"
        $DRY_RUN_CMD ${pkgs.git}/bin/git clone \
          git@github.com:jowi-dev/logs_external.git \
          "$LOG_DIR"
      else
        echo "Log directory exists at $LOG_DIR"
      fi

      SITE_DIR="${sitePersonal}";
      if [ ! -d "$SITE_DIR" ]; then
        $DRY_RUN_CMD mkdir -p "$(dirname "$SITE_DIR")"
        $DRY_RUN_CMD ${pkgs.git}/bin/git clone \
          git@github.com:jowi-dev/jowi-dev.github.io.git \
          "$SITE_DIR"
      else
        echo "Site directory exists at $SITE_DIR"
      fi
    '';

      packages = with pkgs; [
        # Global Languages
        cmake
        (luajit.withPackages (p: with p; [ luajitPackages.vicious ]))
        elixir
        nodejs
        ccls
        gtest
        lldb
        #go
        bun
        ruby
        #rustup
        cargo
        gnumake
        rust-analyzer
        alacritty
        kitty
        odin
        ols

        _1password

        # Global Tooling
        git
        gum
        github-cli
        yarn
        nix-prefetch-github
        htop
        btop
        lazydocker
        lazygit
        

        ctags
        #nodePackages.neovim

        # Custom
        banj-cli.packages.${system}.default
        fnord.packages.${system}.default
        burn-to-iso
        
        #zigpkgs.master

        # Why is this here?
        fzf
        ripgrep
        powerline-fonts
        bat
        lsd
        xclip
        jq
        coreutils
        
      ] ++ (lib.optionals pkgs.stdenv.isLinux [ cosmic-term]) ++ lib.optionals pkgs.stdenv.isDarwin [rubyPackages.cocoapods];
        
    };

  };
}
