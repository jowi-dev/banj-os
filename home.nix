{ config, pkgs, lib, currentSystem, fnord, banj-cli, ... }:
with lib;
let
  burn-to-iso = pkgs.callPackage ./pkgs/burn-to-iso { };
  #_1password = pkgs.callPackage ./pkgs/1password.nix { 
#    currentSystem = currentSystem;
#  };

in {
    imports = [ ./home/nvim ./home/git ./home/shell ];
  	  config = {

      programs.tmux = {
        enable = true;
        plugins = with pkgs.tmuxPlugins; [
          resurrect
          nord
        ];
        terminal = "alacritty";
        shell = "${pkgs.fish}/bin/fish";
        #shell = "\${pkgs.fish}/bin/fish";
        mouse=true;
        escapeTime = 10;
        keyMode = "vi";
        extraConfig = ''
              set-window-option -g mode-keys vi
            '';
      };
    programs.home-manager.enable = true;

    home = with currentSystem.directories; {

      sessionVariables = {
        OPENAI_MODEL = "gpt-4-1106-preview";
        EDITOR = "nvim";
        CONFIG_DIR="${tooling}";
        BANJ_DB="${tooling}/logs/banj-cli.db";
        BASHGPT_CHAT_HOME = "${tooling}/data/bashgpt/assistants/";
        BASHGPT_CONVERSATION_HISTORY_DIR =
          "${tooling}/data/bashgpt/conversations/";

      }; #// currentSystem.cmds;
      stateVersion = "23.11";
      username = currentSystem.user;
      file = currentSystem.extraConfigFiles;

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
