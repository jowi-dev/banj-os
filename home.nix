{ config, pkgs, lib, ... }: 
with lib;
let
    #bash-gpt = pkgs.callPackage  ./pkgs/bash-gpt.nix {};
    burn-to-iso = pkgs.callPackage ./pkgs/burn-to-iso {};
in {
  imports = [
    ./env
    ./nvim
    ./git
    ./tmux
    ./shell
    ./starship

  ];
  config = {
    programs.home-manager.enable = true;

    home = {

      sessionVariables = with config.local-env; {
        OPENAI_API_KEY= openAPIKey;
        OPENAI_MODEL="gpt-4-1106-preview";
        EDITOR="nvim";
        HOME_WIFI_PASSWORD= homeWifiPassword;
        BASHGPT_CHAT_HOME= "${homeDirectory}${toolingDirectory}/logs/bashgpt/";
        BASHGPT_CONVERSATION_HISTORY_DIR="${homeDirectory}${toolingDirectory}/logs/bashgpt/";

      };
      stateVersion = "23.11";
      username = config.local-env.username;
      #homeDirectory = config.local-env.homeDirectory;
      file = {
        ".config/awesome/rc.lua".source = ./linux/config/window-manager/awesome.lua;
        ".config/awesome/xrandr.lua".source = ./linux/config/window-manager/xrandr.lua;
      };
      packages = with pkgs; [
        # Global Languages
        cmake
        (luajit.withPackages (p: with p; [luajitPackages.vicious]))
        elixir
        nodejs
        go 
        bun
        zig
        ruby
        rustup
        alacritty
        kitty


        # Global Tooling
        git 
        gum
        github-cli
        yarn
        nix-prefetch-github
        htop
        ctop

        ctags
        nodePackages.neovim

        # Custom
        #bash-gpt
        burn-to-iso

        # Why is this here?
        fzf
        ripgrep
        powerline-fonts
        bat
        lsd
        xclip
        jq
        coreutils
      ];
    };

  };
}
