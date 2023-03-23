{config, pkgs, lib, ...}: 
with lib;
let
  cfg = config.my-home;
in
{
	options.local-env = {
	    userName = lib.mkOption {
	      type = types.string;
	      default = "";
	      description = ''
		      The system username of the currently logged in user
	      '';
	    };

	    homeDirectory = lib.mkOption {
	      type = types.string;
	      default = "";
	      description = ''
		      The home directory. Usually the output of `echo $HOME`
	      '';
	    };

	    gitUserName = lib.mkOption {
	      type = types.string;
	      default = "jowi";
	      description = ''
		      The username associated to your git account
	      '';
	    };

	    gitEmail = lib.mkOption {
	      type = types.string;
	      default = "";
	      description = ''
		      The email associated with your git account
	      '';
	    };

	    openAPIKey = lib.mkOption {
	      type = types.string;
	      default = "";
	      description = ''
		      The API key associated to your open API account. Leave blank if you do not need ChatGPT integration
	      '';
	    };
	};

}

