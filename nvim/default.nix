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
        #if config.local-env.isMac then beam.packages.erlang.elixir-ls else beam.packages.erlang.elixir_ls
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
      ] ++ (
        let
        erlang_25 = erlangR25.override {
          version = "25.2.3";
          # nix-prefetch-url --unpack https://github.com/erlang/otp/archive/OTP-25.2.3.tar.gz
          sha256 = "10ad3xqrxkcpdbj57n50990d1jhhdmc6rcf7swmf64nf23rcgr55";
          javacSupport = false;
          odbcSupport = false;
          configureFlags = [ "--with-ssl=${lib.getOutput "out" openssl}" ]
            ++ [ "--with-ssl-incl=${lib.getDev openssl}" ];
        };

        beamPkg = beam.packagesWith erlang_25;

        elixir_1_14 = beamPkg.elixir.override {
          version = "1.14.2";
          # nix-prefetch-url --unpack https://github.com/elixir-lang/elixir/archive/refs/tags/v1.14.2.tar.gz
          sha256 = "1w0wda304bk3j220n76bmv4yv0pkl9jca8myipvz7lm6fnsvw500";
        };

        elixir_ls = beamPkg.elixir-ls.override {
          lib = lib // {
            # Merge custom importJSON into lib.
            importJSON = _: {
              version = "0.14.6";
              sha256 = "sha256-O977DZLWPyLafIaOTPZKI4MOtK9E9TDProf2xyk05aI=";
              depsSha256 = "sha256-jF1Plkz1D85aWkiNgeBlJmHndhr7us+8+m/gMkXHvDw=";
            };
          };
          elixir = elixir_1_14;
          mixRelease = beamPkg.mixRelease.override { elixir = elixir_1_14; };
        };
      in
      [
        erlang_25
        elixir_1_14
        elixir_ls
      ]
  );

# .. ";${nvimLuaEnv}/lib/lua/5.1/?.so"
      extraConfig = ''
        let g:elixir_ls_home = "${pkgs.elixir_ls}"
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
