# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, currentSystem, ... }:
with lib;
let
  awesome = pkgs.awesome.overrideAttrs (oldAttrs: {
    buildInputs = oldAttrs.buildInputs ++ [ pkgs.luajitPackages.vicious ];
  });
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #services.blueman.enable=true;

  networking = {
    hostName = currentSystem.name;
    wireless = {
      userControlled.enable = true;
      enable = true; # Enables wireless support via wpa_supplicant.
      networks = {
        Obsidian = {
          pskRaw =
            "dbbeb39d04be3916d99e3a376576c308e0019b4dbf94084bc8c07c1ff3d7f7a0";
        };
        # Have a new wifi config? add it here!
        #        "My Network Name" = {
        #          pskRaw = "generated psk output from wifi-save-config";
        #        };
      };
    };
  };

  # making this configurable so servers can run as lean as possible
  virtualisation.docker.enable = currentSystem.enableContainers;

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

    # TODO - a wayland config? 
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      displayManager = if currentSystem.enableGui then {
        defaultSession = "none+awesome";
        lightdm.enable = true;
      } else {
        startx.enable = true;
      };
      windowManager = if currentSystem.enableGui then {
        awesome = {
          package = awesome;
          enable = true;
          luaModules = [ 
            pkgs.luaPackages.luarocks 
            pkgs.luaPackages.vicious 
          ];
        };
      } else
        { };

    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = currentSystem.enableSound;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = if currentSystem.enableSound then {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  } else {};

  # Nix Options
  nix.settings.experimental-features = "nix-command flakes";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  programs.fish.enable = true;
  users.users.${currentSystem.user} = {
    name = currentSystem.user;
    home = currentSystem.directories.home;
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Joe Williams";
    extraGroups = if currentSystem.enableContainers then
    [ "networkmanager" "wheel" "docker" ]
    else [ "networkmanager" "wheel" ] ;
    packages = if currentSystem.enableGui then with pkgs; [ kate brave wpa_supplicant_gui _1password-gui ] else [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  environment = {
    variables = with currentSystem; {
      NIXOS_CONFIG = "${directories.tooling}/sys/${name}/configuration.nix";
    };
    systemPackages =  with pkgs;  if currentSystem.enableGui then [
      vim
      git
      discord
      gparted
      mangohud
      #bluez
      xorg.xkill
      flameshot
    ] else [vim git];
     

  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
