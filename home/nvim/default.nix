{ config, pkgs, lib, currentSystem,  ... }:
with lib;
let
  # So this is actually pretty cool.
  # We're making a luajit environment with http (and dependencies) available.
  # This is used in the ChatGPT submission code
  nvimLuaEnv =
    pkgs.luajit.withPackages (p: with p; [ http lpeg basexx cqueues cjson ]);

  #nextPackage = nextls.packages.${currentSystem.architecture}.default;

in {
  config = {
    programs.neovim = {
      package = pkgs.neovim-unwrapped;
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      plugins = with pkgs.vimPlugins; [
        awesome-vim-colorschemes
        nerdtree
        # csv-vim
        vim-ccls
        nvim-jqx
        nvim-dap
        elixir-tools-nvim
        vim-graphql
        nvim-treesitter.withAllGrammars
        #nvim-treesitter
        vim-markdown
        tmuxline-vim
        vim-elixir
        vim-nix
        vim-gitgutter
        plenary-nvim
        null-ls-nvim
        nvim-lsp-ts-utils

        telescope-nvim
        telescope-dap-nvim
        telekasten-nvim

        lualine-nvim
        ultisnips

        nvim-lspconfig
        cmp-nvim-lsp
        cmp-nvim-ultisnips
        cmp-nvim-lua
        cmp-nvim-lsp-signature-help
        cmp-buffer
        cmp-path
        cmp-cmdline
        nvim-cmp
      ];

      extraPackages = with pkgs; [
        jq
        tree-sitter
        nodejs

        # Language Servers
        # Bash
        nodePackages.bash-language-server

        # Erlang
        beam.packages.erlang.erlang-ls
        elixir-ls

        # Lua
        lua-language-server
        #luajit

        # for git diffs in telescope
        diff-so-fancy

        # Nix
        nixfmt
        nixpkgs-fmt
        nixd
        statix

        #python-debug
        black
        #python310Full
#        python310Packages.pynvim
#        python310Packages.powerline

        # Typescript
        nodePackages.typescript-language-server

        # Web (ESLint, HTML, CSS, JSON)
        nodePackages.vscode-langservers-extracted

        # Telescope tools
        ripgrep
        fd
        #telescope-fzf-native-nvim

      ];

      extraConfig = with currentSystem.directories; ''
        let g:UltiSnipsSnippetDirectories = ["${tooling}/home/nvim/config/lua/UltiSnips"]

        :lua nvimHome = "${home}/.config/home/nvim/config/lua"
        :lua elixir_tools = "${pkgs.vimPlugins.elixir-tools-nvim}"
        :lua logs_path = "${tooling}/logs"

        :lua package.path = "${home}".."/.config/nvim/?.lua" .. ";${nvimLuaEnv}/share/lua/5.1/?.lua" 
        :lua package.cpath = package.cpath ..";${nvimLuaEnv}/lib/lua/5.1/?.so"
        :lua elixir_tools = "${pkgs.vimPlugins.elixir-tools-nvim}"
        :lua elixir_ls_home = "${pkgs.elixir-ls}"

        :luafile ~/.config/nvim/lua/init.lua

      '';

        #:lua elixir_tools = "${nextPackage}"
    };

    xdg.configFile.nvim = {
      source = ./config;

      recursive = true;
    };
  };
}
