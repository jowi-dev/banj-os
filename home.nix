#  IF THIS `$NIX_PATH is null` error happens again, copy paste this line into your shell
#  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}


{config, pkgs, lib, ...}: 
with lib;
let
  cfg = config.my-home;
in
{
	imports =  [
    ./env
    ./nvim 
    ./git
    ./tmux
    ./bash
    ./starship
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

	config = {
    programs.home-manager.enable = true;
		home = {
      stateVersion = "22.11";
      username = "jowi";
      homeDirectory = "/home/jowi";
      packages = with pkgs; [
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
        xclip
		  ];
	  };
  };
}




