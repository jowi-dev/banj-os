#  IF THIS NIX_PATH error happens again, copy paste this line into your shell
#  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
#
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

	#targets.genericLinux.enable = true;

	options.my-home = {
	    useNeovim = lib.mkOption {

	      type = types.bool;

	      default = true;

	      description = ''

		Include neovim with my customizations

	      '';

	    };
	};


#	programs.bash = {
#
#		enable = true;
#
#
#	};
#
#	programs.alacritty = {
#
#		enable = true;
#
#	};


	options.home-manager = {

		enable = true;

		path = "/home/jowi/.nix-profile/bin/home-manager";

    	};

	config = {

		home = {

	stateVersion = "18.09";

	username = "jowi";

	homeDirectory = "/home/jowi";
		packages = [



	    

			pkgs.home-manager

			pkgs.git 

			pkgs.neovim-unwrapped

			pkgs.tmux

			pkgs.ctags 

			pkgs.luajit 

			pkgs.sumneko-lua-language-server

			pkgs.elixir 

			pkgs.nodejs 

			pkgs.nodePackages.neovim

			pkgs.python310Full

			pkgs.ruby

			pkgs.python310Packages.pynvim

			pkgs.python310Packages.powerline

			pkgs.rustup

			pkgs.fzf

			pkgs.ripgrep

			pkgs.powerline-fonts

			pkgs.bat

			pkgs.lsd

			pkgs.starship

			pkgs.tmuxPlugins.resurrect

		];
			
		};


};

}




