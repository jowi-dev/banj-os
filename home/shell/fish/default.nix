{ config, pkgs, lib, ... }:
let
  inherit (import ../../../lib/mkaliases.nix) mkaliases;
  aliases = mkaliases config.local-env.system;
in
 {
  programs.fish = {
    enable = true;

    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" ([
      "source ${pkgs.fishPlugins.bobthefish}/share/fish/vendor_functions.d/fish_prompt.fish"
      "source ${pkgs.fishPlugins.bobthefish}/share/fish/vendor_functions.d/fish_right_prompt.fish"
      "source ${pkgs.fishPlugins.bobthefish}/share/fish/vendor_functions.d/fish_title.fish"
      "source ${pkgs.fishPlugins.bobthefish}/share/fish/vendor_functions.d/__bobthefish_colors.fish"
      "source ${pkgs.fishPlugins.bobthefish}/share/fish/vendor_functions.d/__bobthefish_display_colors.fish"
      "source ${pkgs.fishPlugins.bobthefish}/share/fish/vendor_functions.d/__bobthefish_glyphs.fish"
      "source ${pkgs.fishPlugins.bobthefish}/share/fish/vendor_functions.d/bobthefish_display_colors.fish"
      "source ${pkgs.fishPlugins.bobthefish}/share/fish/vendor_functions.d/fish_greeting.fish"
      "source ${pkgs.fishPlugins.bobthefish}/share/fish/vendor_functions.d/fish_mode_prompt.fish"
      #(builtins.readFile ./config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]));
    #package = pkgs.fish;
    
    #useBabelfish=true;
    #babelfishPackage=pkgs.babelfish;
#    plugins = [
#      pkgs.fishPlugins.foreign-env
#   ];
    shellAliases = aliases;
#    vendor = {
#      completions.enable=true;
#      config.enable=true;
#      functions.enable=true;
#    };
  };
}

