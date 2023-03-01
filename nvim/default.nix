{ config, pkgs, lib, ... }:

with lib;

let

  python-debug = pkgs.python3.withPackages (p: with p; [ debugpy ]);

in

{

  config = mkIf config.my-home.useNeovim {

    programs.neovim = {

      package = pkgs.neovim-unwrapped;

      enable = true;

      viAlias = true;

      vimAlias = true;

      vimdiffAlias = true;



      plugins = with pkgs.vimPlugins; [

		palenight-vim



		nerdtree



		csv-vim



		vim-fugitive



		vim-merginal



		tmuxline-vim



		vim-elixir



		vim-gitgutter



		vim-markdown



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



      ];



      extraPackages = with pkgs; [

        tree-sitter

        nodejs

        # Language Servers

        # Bash

        nodePackages.bash-language-server


        # Elixir

        beam.packages.erlang.elixir_ls

        # Erlang

        beam.packages.erlang.erlang-ls

	# ZIG BABY
	zig




        # Lua

        lua-language-server

        # Nix

        rnix-lsp

        nixpkgs-fmt

        statix

	#python-debug
	black
        # Typescript

        nodePackages.typescript-language-server

        # Web (ESLint, HTML, CSS, JSON)

        nodePackages.vscode-langservers-extracted

        # Telescope tools

        ripgrep

        fd

      ];



      # let g:python_debug_home = "${python-debug}"

      extraConfig = ''

        let g:elixir_ls_home = "${pkgs.beam.packages.erlang.elixir_ls}"

        :luafile ~/.config/nvim/lua/init.lua

      '';

    };



    xdg.configFile.nvim = {

      source = ./config;

      recursive = true;

    };

  };

}
