{ config, pkgs, lib, ... }:
with lib; {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      set -o vi
      source ~/.nix-profile/etc/profile.d/nix.sh

      alias bs="echo ':terminal' | nvim -s --listen /tmp/$(tmux display-message -p '#S').pipe"
      alias hmc="home-manager expire-generations '-2 days'"
      alias hml="home-manager generations"
      alias hms="home-manager switch"
    '';

  };
}
