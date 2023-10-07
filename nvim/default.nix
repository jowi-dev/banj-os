{ config, pkgs, lib, ... }:
with lib;
let
  #python-debug = pkgs.python3.withPackages (p: with p; [ debugpy ]);

  # So this is actually pretty cool.
  # We're making a luajit environment with http (and dependencies) available.
  # This is used in the ChatGPT submission code
  nvimLuaEnv = pkgs.luajit.withPackages (p: with p; [ http lpeg basexx cqueues cjson ]);

in {
  config = {
    programs.neovim = {
      package = pkgs.neovim-unwrapped;
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        palenight-vim
        nerdtree
        # csv-vim
        vim-fugitive
        vim-merginal
        tmuxline-vim
        vim-elixir
        vim-nix
        vim-gitgutter
        nvim-treesitter
        playground
        nvim-lspconfig
        plenary-nvim
        null-ls-nvim
        nvim-lsp-ts-utils
        telescope-nvim
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        nvim-cmp
        lualine-nvim
        ultisnips
        elixir-tools-nvim
      ];

      extraPackages = with pkgs;
        [
          tree-sitter
          nodejs

          # Language Servers
          # Bash
          nodePackages.bash-language-server

          # Erlang
          beam.packages.erlang.erlang-ls
          beam.packages.erlang.elixir-ls

          # ZIG BABY
          zig

          # Lua
          lua-language-server
          luajit

          # Nix
          nixfmt
          rnix-lsp
          nixpkgs-fmt
          statix

          #python-debug
          black
          python310Full
          python310Packages.pynvim
          python310Packages.powerline

          # Typescript
          nodePackages.typescript-language-server

          # Web (ESLint, HTML, CSS, JSON)
          nodePackages.vscode-langservers-extracted

          # Telescope tools
          ripgrep
          fd
        ];

      extraConfig = ''
        let g:elixir_ls_home = "${pkgs.elixir-ls}"
        let g:UltiSnipsSnippetDirectories = ["${config.local-env.homeDirectory}/.config/home-manager/nvim/config/lua/UltiSnips"]

        :lua elixir_tools = "${pkgs.vimPlugins.elixir-tools-nvim}"

        :lua open_api_key = "${config.local-env.openAPIKey}"
        :lua package.path = "${config.local-env.homeDirectory}".."/.config/nvim/?.lua" .. ";${nvimLuaEnv}/share/lua/5.1/?.lua" 
        :lua package.cpath = package.cpath ..";${nvimLuaEnv}/lib/lua/5.1/?.so"
        :luafile ~/.config/nvim/lua/init.lua
      '';

    };

    xdg.configFile.nvim = {
      source = ./config;

      recursive = true;
    };
  };
}

##how do you get the current derivation path in nix to reference in a variable in nix code?
##In Nix, you can get the current derivation path by using the `stdenv` package and calling the `mkDerivation` function. Here's an example:
##
##```nix
##let
##  pkgs = import <nixpkgs> {};
##  stdenv = pkgs.stdenv;
##in
##stdenv.mkDerivation {
##  name = "my-derivation";
##  buildCommand = ''
##    echo "The current derivation path is $out"
##  '';
##}
##```
##
##In this example, the `buildCommand` is a bash script that will be executed during the build process. The `$out` variable is automatically defined by Nix and contains the path to the current derivation.
##
##Please note that the derivation path is not known until the derivation is actually built. This is because the path includes a hash of all inputs to the derivation, and these inputs can change between the time the derivation is defined and the time it is built. Therefore, you cannot reference the derivation path in a variable at the time the derivation is defined.
##
##In Nix, you can't directly get the derivation path of the current derivation because it's not determined until the derivation is built. The derivation path is a hash of the derivation's attributes and its dependencies, so it can't be known until everything is evaluated.
##
##However, you can reference the output path of a derivation using the `outPath` attribute. For example:
##
##```nix
##let
##  myDerivation = derivation { /* ... */ };
##in
##  myDerivation.outPath
##```
##
##This will give you the path in the Nix store where the result of `myDerivation` will be stored once it's built. But note that this isn't the same as the derivation path itself, which is a path to a .drv file describing the derivation.
##
##If you need to pass the output path of a derivation to the derivation itself, you can use a fixed-output derivation, which allows you to specify the hash of the output ahead of time. But this is generally only used for fetching resources from the network, not for normal builds.
##
##If you want to reference a file from the current derivation in the Nix expression, you can use the `./.` syntax:
##
##```nix
##let
##  myFile = ././my-file;
##in
##  derivation { /* ... */ }
##```
##
##This will create a derivation that includes `my-file` in its sources. You can then reference this file in the build script. But again, this isn't the same as getting the derivation path of the current derivation.
##
##In general, trying to get the derivation path of the current derivation is likely a sign that you're trying to do something that doesn't fit well with the Nix model. You might be able to achieve what you want with a different approach.
