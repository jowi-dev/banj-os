# IF THIS `$NIX_PATH is null` error happens again, copy paste this line into your shell
#  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
# Note - this PATH ^ does not work for WSL under the recommended install b/c WSL uses single user install vs per user. TODO - find the single user path and if/else it.

{ config, pkgs, lib, ... }: 
with lib;
let
    bunclang = pkgs.llvmPackages_15.libclang.override {ignoreCollisions= true;};
    #bungnat = pkgs.gnat11.override {ignoreCollisions=true;};
    bununtils = pkgs.binutils_nogold.override {ignoreCollisions=true;};
        #llvmPackages_15.clangNoLibc
    bash-gpt = pkgs.callPackage  ./pkgs/bash-gpt.nix {};

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
        OPENAI_API_MODEL="gpt-4";
      };
      stateVersion = "23.11";
      username = config.local-env.username;
      homeDirectory = config.local-env.homeDirectory;
      packages = with pkgs; [
        # Global Languages
        cmake
        luajit
        elixir
        nodejs
        go 
        bun
        zig
        ruby
        rustup


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

#how to add environment variables to environment from home manager nix
#Home Manager is a tool for managing a user's home directory using the Nix package manager. It allows you to declaratively specify your home directory configuration, including environment variables.
#
#To add environment variables using Home Manager, you'll need to edit your `home.nix` configuration file, which is typically located at `~/.config/nixpkgs/home.nix`. Here's how you can add environment variables:
#
#1. Open your `home.nix` file in a text editor.
#
#2. Find the `home.sessionVariables` attribute set. If it doesn't exist, you can create it.
#
#3. Add your environment variables within the `home.sessionVariables` attribute set.
#
#Here's an example of how to add the `EDITOR` and `LANG` environment variables:
#
#```nix
#{ config, pkgs, ... }:
#
#{
#  # Other Home Manager configuration ...
#
#  home.sessionVariables = {
#    # Set the default editor to vim
#    EDITOR = "vim";
#    # Set the language/locale settings
#    LANG = "en_US.UTF-8";
#  };
#
#  # More Home Manager configuration ...
#}
#```
#
#4. After you've added your environment variables, save the file.
#
#5. To apply the changes, run the Home Manager switch command:
#
#```sh
#home-manager switch
#```
#
#This will rebuild your user environment and set the specified environment variables.
#
#Keep in mind that environment variables set with `home.sessionVariables` will be available globally for your user session. If you need to set environment variables for a specific package or service, you might need to use a different attribute or method depending on the context.
#
#For example, if you're setting environment variables for a systemd user service managed by Home Manager, you would use the `serviceConfig.Environment` attribute inside the service configuration.
#
#For more advanced usage and conditional environment variables, you may need to use Nix expressions to set the variables based on certain conditions or system properties. Always refer to the Home Manager documentation for the most accurate and up-to-date information.

#In this example, `home.activation` is used to define a new activation block called `myCustomActivationScript`. The `lib.hm.dag.entryAfter` function specifies that this script should run after the `writeBoundary` activation step, which is a predefined step in Home Manager.
#
#The script itself is a multi-line string (denoted by `''`) containing the bash commands you want to run. In this case, it prints a message, creates a new file in the user's home directory, and calls a custom function defined earlier in the file.
#
#Remember to run `home-manager switch` after updating your `home.nix` configuration to apply the changes.
#
#Keep in mind that Home Manager is intended for NixOS or for users who have Nix installed on other Unix-like operating systems. The configuration syntax and behavior are specific to the Nix ecosystem.
#
##how to change nix store version to unstable
##To switch to the Nix unstable channel, follow these steps:
##
##1. Remove the current channel:
##
##   ```bash
##   sudo nix-channel --remove nixpkgs
##   ```
##
##2. Add the unstable channel:
##
##   ```bash
##   sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable
##   ```
##
##3. Update the channel:
##
##   ```bash
##   sudo nix-channel --update
##   ```
##
##4. Now you can install packages from the unstable channel.
##
##Please note that switching to the unstable channel might bring some instability or bugs as the packages in this channel are not as thoroughly tested as those in the stable channel. Use it at your own risk.
