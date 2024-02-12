# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
with lib;
let
  awesome = pkgs.awesome.overrideAttrs (oldAttrs: {
    buildInputs = oldAttrs.buildInputs ++ [ pkgs.luajitPackages.vicious ];
  });
in {
  imports = [ # Include the results of the hardware scan.
    ../env
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos";
    wireless = {
      networks.Obsidian.psk = "countryclub";
      userControlled.enable = true;
      enable = true; # Enables wireless support via wpa_supplicant.
    };
  };

  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

  };
  services = {
    # Enable CLI tools for checking battery information
    acpid.enable = true;

  # Enable the X11 windowing system.
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      displayManager = {
        defaultSession = "none+awesome";
        lightdm.enable = true;
      };
      windowManager = {
        awesome = {
          package = awesome;
          enable = true;
          luaModules = [ pkgs.luaPackages.luarocks pkgs.luaPackages.vicious ];

        };

      };

    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Nix Options
  nix.settings.experimental-features = "nix-command flakes";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  programs.fish.enable = true;
  users.users.jowi = {
    name = "jowi";
    home = "/home/jowi";
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Joe Williams";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ kate brave ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment = {
    variables = with config.local-env; {
      NIXOS_CONFIG =
        "${homeDirectory}${toolingDirectory}/linux/configuration.nix";
      OPENAI_API_KEY = "${openAPIKey}";
      HOME_WIFI_PASSWORD = "${homeWifiPassword}";
    };
    systemPackages = with pkgs; [
      vim
      git
      discord
      gparted
      mangohud
      xorg.xkill
      flameshot
    ];

  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
