{ config, pkgs, lib, currentSystem, fnord, banj-cli, publisher, ... }:
with lib;
let
  burn-to-iso = pkgs.callPackage ./pkgs/burn-to-iso { };
  logDirPersonal = "${currentSystem.directories.home}/log-dir";
  sitePersonal = "${currentSystem.directories.home}/sites/personal";
  getSecret = pkgs.writeShellScript "get-secret" ''
    ${pkgs._1password-cli}/bin/op read "op://osr3ibpmvndmdsobguo3egxm6i/openai-secret/password"
  '';
in
{
  imports = [ ./home/nvim ./home/git ./home/shell ./home/tmux ];
  config = {

    programs.home-manager.enable = true;

    home = with currentSystem.directories; {

      sessionVariables = {
        OPENAI_MODEL = "gpt-4-1106-preview";
        # used by fnord
        OPENAI_API_KEY="$(${getSecret})";
        EDITOR = "nvim";
        CONFIG_DIR = "${tooling}";
        FLAKE = "${currentSystem.name}";
        LOG_DIR_PERSONAL = logDirPersonal;
        SITE_PERSONAL = sitePersonal;

      };
      stateVersion = "23.11";
      username = currentSystem.user;
      file = currentSystem.extraConfigFiles;

      # This is dynamic GH user switching via git
      activation.gitUser = ''
        gh_user=$(gh api user --jq '.name' 2>/dev/null || echo "Default User")
        gh_email=$(gh api user --jq '.email' 2>/dev/null || echo "default@example.com")
        
        if [ "$gh_user" != "Default User" ]; then
          git config --global user.name "$gh_user"
          git config --global user.email "$gh_email"
        fi
      '';


      activation.cloneLogRepo = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
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

        _1password-cli

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
        publisher.packages.${system}.default
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

      ] ++ (lib.optionals pkgs.stdenv.isLinux [ cosmic-term ]) ++ lib.optionals pkgs.stdenv.isDarwin [ rubyPackages.cocoapods ];

    };

  };
}
