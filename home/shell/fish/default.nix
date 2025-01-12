{ config, pkgs, lib, currentSystem, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" ([
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]));
    # TODO - enable comments
    #package = pkgs.fish;

    #useBabelfish=true;
    #babelfishPackage=pkgs.babelfish;
    #    plugins = [
    #      pkgs.fishPlugins.foreign-env
    #   ];
    shellAliases = currentSystem.shell.aliases;
    #    vendor = {
    #      completions.enable=true;
    #      config.enable=true;
    #      functions.enable=true;
    #    };
  };
}

