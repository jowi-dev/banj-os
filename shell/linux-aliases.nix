{
  makeLinuxAliases = system: {
    switch = "sudo nixos-rebuild switch --flake ${system}/.";
    templates="lsd ${system}/templates";
    battery = "acpi";
    sleep = "systemctl hibernate";


    # Screen reorganization commands
    display-duplicate = "xrandr --auto";
    display-extended =
      "monitor-duplicate && xrandr --output eDP-1 --right-of HDMI-2";
    display-single-laptop = "monitor-duplicate && xrandr --output HDMI-2 --off";
    display-single-desktop = "monitor-duplicate && xrandr --output eDP-1 --off";
  };
}
