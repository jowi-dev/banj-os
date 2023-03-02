#  IF THIS `$NIX_PATH is null` error happens again, copy paste this line into your shell
#  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}


{config, pkgs, lib, ...}: 
with lib;
let
  cfg = config.my-home;
in
{
	imports =  [
    ./nvim 
    ./git
    ];

	options.my-home = {
	    useNeovim = lib.mkOption {
	      type = types.bool;
	      default = true;
	      description = ''
		      Include neovim with my customizations
	      '';
	    };
	};

	options.home-manager = {
		enable = true;
		path = "/home/jowi/.nix-profile/bin/home-manager";
  };

	config = {
		home = {
      stateVersion = "18.09";
      username = "jowi";
      homeDirectory = "/home/jowi";
      packages = with pkgs; [
        home-manager
        git 
        neovim-unwrapped
        tmux
        ctags 
        luajit 
        sumneko-lua-language-server
        elixir 
        nodejs 
        nodePackages.neovim
        python310Full
        ruby
        python310Packages.pynvim
        python310Packages.powerline
        rustup
        fzf
        ripgrep
        powerline-fonts
        bat
        lsd
        starship
        tmuxPlugins.resurrect
		  ];
	  };
  };
}




