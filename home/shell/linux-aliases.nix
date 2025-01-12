{
  makeLinuxAliases = system: {
    rebuild = "sudo nixos-rebuild switch --flake ${system}/.";
    templates = "lsd ${system}/templates";
    battery = "acpi";
    sleep = "systemctl hibernate";


    # Screen reorganization commands
    display-duplicate = "xrandr --auto";
    display-extended =
      "display-duplicate && xrandr --output eDP-1 --right-of HDMI-2";
    display-single-laptop = "display-duplicate && xrandr --output HDMI-2 --off";
    display-single-desktop = "display-duplicate && xrandr --output eDP-1 --off";

    # Wifi Commands: wifi
    wifi-save-config = "wpa_passphrase";
    wifi = "wpa_gui";

  };
}
