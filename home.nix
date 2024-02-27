#{ config, pkgs, lib, currentSystem, bash-gpt, llama-cpp, ... }:
{ config, pkgs, lib, currentSystem, bash-gpt, ... }:
with lib;
let
  burn-to-iso = pkgs.callPackage ./pkgs/burn-to-iso { };
  _1password = pkgs.callPackage ./pkgs/1password.nix { 
    currentSystem = currentSystem;
  };

in {
  imports = [ ./home/nvim ./home/git ./home/tmux ./home/shell ];
  config = {
    programs.home-manager.enable = true;

    home = with currentSystem.directories; {

      sessionVariables = {
        OPENAI_MODEL = "gpt-4-1106-preview";
        EDITOR = "nvim";
        BASHGPT_CHAT_HOME = "${tooling}/data/bashgpt/assistants/";
        BASHGPT_CONVERSATION_HISTORY_DIR =
          "${tooling}/data/bashgpt/conversations/";

      };
      stateVersion = "23.11";
      username = currentSystem.user;
      file = currentSystem.extraConfigFiles;

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

        # Why is this here?
        fzf
        ripgrep
        powerline-fonts
        bat
        lsd
        xclip
        jq
        coreutils
        
      ] ++ (if currentSystem.isMac then [] else [wavemon _1password llama-cpp.packages.${system}.default cosmic-term]);
        
    };

  };
}
