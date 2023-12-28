{ config, pkgs, lib, ... }: 
with lib;
let
    bash-gpt = pkgs.callPackage  ./pkgs/bash-gpt.nix {};
    myAwesomeConfig = pkgs.writeTextFile{
      name = "/.config/awesome/rc.lua"; 
      text = builtins.readFile "${config.local-env.homeDirectory}/.config/nix-config/linux/config/window-manager/awesome-gpt-1.lua";
    };

    xrandrConfig = pkgs.writeTextFile{
      name = "/.config/awesome/xrandr.lua"; 
      text = builtins.readFile "${config.local-env.homeDirectory}/.config/nix-config/linux/config/window-manager/xrandr.lua";
    };

in {
  imports = [
    ./env
    ./nvim
    ./git
    ./tmux
    ./bash
    ./starship

  ];
  config = {
    programs.home-manager.enable = true;

    home = {

      sessionVariables = {
        OPENAI_API_KEY=config.local-env.openAPIKey;
        OPENAI_MODEL="gpt-4-1106-preview";
      };
      stateVersion = "23.11";
      username = config.local-env.username;
      homeDirectory = config.local-env.homeDirectory;
      file = {
        ".config/awesome/rc.lua".source = myAwesomeConfig;
        ".config/awesome/xrandr.lua".source = xrandrConfig;
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
        bash-gpt

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
