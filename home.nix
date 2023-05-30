#  IF THIS `$NIX_PATH is null` error happens again, copy paste this line into your shell
#  export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
# Note - this PATH ^ does not work for WSL under the recommended install b/c WSL uses single user install vs per user. TODO - find the single user path and if/else it.


{config, pkgs, lib, ...}: 
{
	imports =  [
    ./env
    ./nvim 
    ./git
    ./tmux
    #./bash
    ./zsh
    ./starship
    ];

	config = {
    programs.home-manager.enable = true;
		home = {
      stateVersion = "22.11";
      username = config.local-env.username;
      homeDirectory = config.local-env.homeDirectory;
      packages = with pkgs; [
        ctags 
        luajit 
        sumneko-lua-language-server
        elixir 
        nodejs 
        nodePackages.neovim
        yarn
        bun
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




