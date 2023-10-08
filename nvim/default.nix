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
        nvim-jqx
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
        telekasten-nvim
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
          jq
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

        :lua nvimHome = "${config.local-env.homeDirectory}/.config/nvim/lua"
        :lua elixir_tools = "${pkgs.vimPlugins.elixir-tools-nvim}"
        :lua logs_path = "${config.local-env.homeDirectory}/.config/home-manager/logs"

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
