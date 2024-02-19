{ config, pkgs, lib, bash-gpt, ... }:
with lib;
let
  burn-to-iso = pkgs.callPackage ./pkgs/burn-to-iso { };
  _1password = pkgs.callPackage ./pkgs/1password.nix { };

  inherit (import ./lib/get_system_type.nix) isMac;

in {
  imports = [
    ./env
    ./home/nvim
    ./home/git
    ./home/tmux
    ./home/shell
  ];
  config = {
    programs.home-manager.enable = true;

    home =  with config.local-env; {

      
      sessionVariables = {
        OP_SESSION_my="$(op signin my --raw)";
        # TODO - this needs to be aliased before all chat commands
        #OPENAI_API_KEY="op://Personal/openai-secret/password";
        OPENAI_MODEL = "gpt-4-1106-preview";
        EDITOR = "nvim";
        HOME_WIFI_PASSWORD = homeWifiPassword;
        BASHGPT_CHAT_HOME = "${homeDirectory}${toolingDirectory}/data/bashgpt/assistants/";
        BASHGPT_CONVERSATION_HISTORY_DIR =
          "${homeDirectory}${toolingDirectory}/data/bashgpt/conversations/";

      };
      stateVersion = "23.11";
      username = username;
      file = if isMac system then
        { }
      else
        import ./linux/config/window-manager;
      packages = with pkgs; [
        # Global Languages
        cmake
        (luajit.withPackages (p: with p; [ luajitPackages.vicious ]))
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
        btop
        lazydocker
        lazygit

        ctags
        nodePackages.neovim

        # Custom
        bash-gpt.packages.${system}.default
        burn-to-iso
        _1password

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
