# Darwin Config
{ config, pkgs, lib, currentSystem, ... }:
with lib;
let 
  cfg = config.my-darwin;
  #myFish = pkgs.wrapFish { pluginPkgs = with pkgs; [fishPlugins.bass babelfish];};

in {


  options.my-darwin = {
    isWork = lib.mkEnableOption "work profile";
    enableSudoTouch = lib.mkEnableOption "sudo touch id";

    theme = lib.mkOption {
      type = types.str;
      default = "nord";
      description = ''
        Theme to apply
      '';
    };
  };

  config = {
    environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";
    environment.pathsToLink = ["/share/doc"];

    users.users.${currentSystem.user} = {
      name = currentSystem.user;
      home = currentSystem.directories.home;
      shell = pkgs.fish;
      #shell = myFish;
    };

    # Make sure nix always runs in multi-user mode on Mac
    services.nix-daemon.enable = true;

    nixpkgs.config.allowUnfree = true;
    nix = {
      package = pkgs.nixStable;
      # Add cache for nix-community, used mainly for neovim nightly
      settings = {
        substituters = [ "https://nix-community.cachix.org" ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
      # Enable Flakes
      extraOptions = "experimental-features = nix-command flakes";
      # An aarch64-linux vm running nixos, so I can build my raspberry pi config
      # on it and deploy remotely.  Building on the rpi3 directly is super slow.
      buildMachines = [{
        hostName = "192.168.123.132";
        sshUser = "root";
        systems = [ "aarch64-linux" "x86_64-linux" ];
        supportedFeatures = [ "big-parallel" ];
      }];
      # Required for the above build machines to be used.
      distributedBuilds = true;
    };

    homebrew = {
      enable = config.my-darwin.isWork;
      onActivation = { cleanup = "uninstall"; };
      taps = [{
        name = "toasttab/toast";
        clone_target = "git@github.com:toasttab/homebrew-toast";
      }];
      brews = [ "libffi" "cocoapods" "lunchbox" "obsidian" ];
    };

    # Create /etc/zshrc that loads the nix-darwin environment.
      # zsh is the default shell on Mac and we want to make sure that we're
    # configuring the rc correctly with nix-darwin paths.
    programs.zsh.enable = true;
    programs.zsh.shellInit = ''
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      # End Nix
      '';

    programs.fish.enable = true;
    programs.fish.shellInit = ''
      # Nix
      if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
        source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      end
      # End Nix
      '';

    environment.shells = with pkgs; [bashInteractive zsh fish];
#    programs.zsh = {
#      enable = true;
#    };
#    programs.fish = {
#      enable = true;
#      useBabelfish = true;
#
##      # This fixes a bug between nix darwin and home-manager over completion conflicts
##      # Completion is enabled in home-manager config
##      enableCompletion = false;
##      promptInit = "";
#      loginShellInit = let
#      # This naive quoting is good enough in this case. There shouldn't be any
#      # double quotes in the input string, and it needs to be double quoted in case
#      # it contains a space (which is unlikely!)
#      dquote = str: "\"" + str + "\"";
#
#      makeBinPathList = map (path: path + "/bin");
#    in ''
#      fish_add_path --move --prepend --path ${lib.concatMapStringsSep " " dquote (makeBinPathList config.environment.profiles)}
#      set fish_user_paths $fish_user_paths
#    '';
#    };

    security.pam.enableSudoTouchIdAuth = cfg.enableSudoTouch;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;

    system.keyboard = { enableKeyMapping = true; };

    system.defaults = {
      dock = {
        orientation = "bottom";
        showhidden = true;
        mineffect = "genie";
        minimize-to-application = true;
        launchanim = true;
        show-process-indicators = true;
        mru-spaces = true;
      };
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark"; # set dark mode
      };
    };
  };

}
