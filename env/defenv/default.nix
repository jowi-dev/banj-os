{ config, pkgs, lib, ... }:
with lib;
let cfg = config.local-env;
in {
  options.local-env = {
    system = mkOption {
      type = types.str;
      default = "";
      description = "the system architecture of the current system";
    };
    username = mkOption {
      type = types.str;
      default = "";
      description =
        "The system username of the currently logged in user\n      ";
    };

    homeDirectory = mkOption {
      type = types.str;
      default = "";
      description =
        "The home directory. Usually the output of `echo $HOME`\n      ";
    };

     toolingDirectory = mkOption {
      type = types.str;
      default = "";
      description =
        "The home directory. Usually the output of `echo $HOME`\n      ";
    };

    gitUserName = mkOption {
      type = types.str;
      default = "jowi";
      description =
        "The username associated to your git account\n      ";
    };

    gitEmail = mkOption {
      type = types.str;
      default = "";
      description = "The email associated with your git account\n      ";
    };

    homeWifiPassword = mkOption {
      type = types.str;
      default = "";
      description =
        "The Wifi password most often used on this machine\n      ";
    };
  };

}

