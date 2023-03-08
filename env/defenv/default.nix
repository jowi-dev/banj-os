{config, pkgs, lib, ...}: 
with lib;
let
  cfg = config.local-env;
in
{
	options.local-env = {
	    username = mkOption {
	      type = types.str;
	      default = "";
	      description = ''
		      The system username of the currently logged in user
	      '';
	    };

	    homeDirectory = mkOption {
	      type = types.str;
	      default = "";
	      description = ''
		      The home directory. Usually the output of `echo $HOME`
	      '';
	    };

	    gitUserName = mkOption {
	      type = types.str;
	      default = "jowi";
	      description = ''
		      The username associated to your git account
	      '';
	    };

	    gitEmail = mkOption {
	      type = types.str;
	      default = "";
	      description = ''
		      The email associated with your git account
	      '';
	    };

	    openAPIKey = mkOption {
	      type = types.str;
	      default = "";
	      description = ''
		      The API key associated to your open API account. Leave blank if you do not need ChatGPT integration
	      '';
	    };
  };

}

