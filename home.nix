{ config, pkgs, lib, bash-gpt, ... }:
with lib;
let
  burn-to-iso = pkgs.callPackage ./pkgs/burn-to-iso { };

  inherit (import ./nix_functions/get_system_type.nix) isMac;

in {
  imports = [
    ./env
    ./nvim
    ./git
    #./tmux
    ./shell
    ./starship

  ];
  config = {
    programs.home-manager.enable = true;

    home = {

      sessionVariables = with config.local-env; {
        OPENAI_API_KEY = openAPIKey;
        OPENAI_MODEL = "gpt-4-1106-preview";
        EDITOR = "nvim";
        HOME_WIFI_PASSWORD = homeWifiPassword;
        BASHGPT_CHAT_HOME = "${homeDirectory}${toolingDirectory}/logs/bashgpt/";
        BASHGPT_CONVERSATION_HISTORY_DIR =
          "${homeDirectory}${toolingDirectory}/logs/bashgpt/";

      };
      stateVersion = "23.11";
      username = config.local-env.username;
      file = if isMac config.local-env.system then
        import ./linux/config/window-manager
      else
        { };
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
        ctop

        ctags
        nodePackages.neovim

        # Custom
        bash-gpt.packages.${config.local-env.system}.default
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
