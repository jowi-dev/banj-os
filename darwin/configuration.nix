# Darwin Config
{ config, pkgs, lib, ... }:
with lib;
let cfg = config.my-darwin;
in {

  imports = [
    <home-manager/nix-darwin>

  ];

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

    users.users.jwilliams = {
      name = "jwilliams";
      home = "/Users/jwilliams";
    };
    home-manager.users.jwilliams = {
      path = "${config.home.homeDirectory}/.config/nixpkgs/home.nix";
      imports = [ ../home.nix ];

      #      imports = [
      #     # ../env
      #     # ../env/defenv
      #     ../nvim
      #     ../tmux
      #     ../starship
      #      ];
      home = {

        stateVersion = "22.11";
        username = "jwilliams";
        homeDirectory = "/Users/jwilliams";
        #packages = with pkgs; [
      };

    };
    # Make sure nix always runs in multi-user mode on Mac
    services.nix-daemon.enable = true;

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
      brews = [ "libffi" "cocoapods" "lunchbox" ];
    };

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh = {
      enable = true;
      # This fixes a bug between nix darwin and home-manager over completion conflicts
      # Completion is enabled in home-manager config
      enableCompletion = false;
      promptInit = "";
    };

    security.pam.enableSudoTouchIdAuth = cfg.enableSudoTouch;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;

    system.keyboard = {
      enableKeyMapping = true;
      #remapCapsLockToControl = true;
    };

    system.defaults = {
      dock = {
        orientation = "bottom";
        showhidden = true;
        mineffect = "genie";
        minimize-to-application = true;
        launchanim = true;
        show-process-indicators = true;
        # tilesize = 48;
        mru-spaces = true;
      };
      finder = {
        # AppleShowAllExtensions = true;
        # FXEnableExtensionChangeWarning = false;
        # CreateDesktop = false; # disable desktop icons
      };
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark"; # set dark mode
      };
    };
  };

}
