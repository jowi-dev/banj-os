{ config, pkgs, lib, ... }:
with lib;
let
  python-debug = pkgs.python3.withPackages (p: with p; [ debugpy ]);
  nvimLuaEnv = pkgs.luajit.withPackages (p: with p; [http lpeg basexx cqueues cjson]);
in
{
  config =  {
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
        # Http packages for makin bacon pancakes w/ chatGPT
        #luajitPackages.rest-nvim
        luajit
        #luajitPackages.http

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

# .. ";${nvimLuaEnv}/lib/lua/5.1/?.so"
      extraConfig = ''
        let g:elixir_ls_home = "${pkgs.beam.packages.erlang.elixir_ls}"
        let g:UltiSnipsSnippetDirectories = ["lua/UltiSnips"]

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
