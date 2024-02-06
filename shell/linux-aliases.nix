# {config, ...}:
{
  makeLinuxAliases = system: {
    switch = "sudo nixos-rebuild switch --flake ${system}/.";
    monitor-duplicate = "xrandr --auto";
    monitor-extended =
      "monitor-duplicate && xrandr --output eDP-1 --right-of HDMI-2";
    monitor-single-laptop = "monitor-duplicate && xrandr --output HDMI-2 --off";
    monitor-single-desktop = "monitor-duplicate && xrandr --output eDP-1 --off";
  };
}
