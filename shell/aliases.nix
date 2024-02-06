{
  switch="sudo nixos-rebuild switch --flake ~/.config/nix-config/.";

  ports="lsof -i -P -n";
  port-kill="kill $(lsof -t -i:4369)";

  flake-move-out="mv flake.nix flake.lock ~/";
  flake-move-in="mv ~/flake.nix ~/flake.lock ./";
  flake-hide="git add --intent-to-add flake.nix flake.lock && git update-index --assume-unchanged flake.nix flake.lock";

  bs="echo ':terminal' | nvim -s --listen /tmp/$(tmux display-message -p '#S').pipe";

  monitor-duplicate="xrandr --auto";
  monitor-extended="monitor-duplicate && xrandr --output eDP-1 --right-of HDMI-2";
  monitor-single-laptop="monitor-duplicate && xrandr --output HDMI-2 --off";
  monitor-single-desktop="monitor-duplicate && xrandr --output eDP-1 --off";
}

