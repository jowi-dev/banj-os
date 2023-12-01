{ config, pkgs, lib, ... }:
with lib; {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      set -o vi
      source ~/.nix-profile/etc/profile.d/nix.sh
      alias ports="lsof -i -P -n"
      alias port-kill="kill $(lsof -t -i:4369)"

      alias bs="echo ':terminal' | nvim -s --listen /tmp/$(tmux display-message -p '#S').pipe"
      alias hmc="home-manager expire-generations '-2 days'"
      alias hml="home-manager generations"
      alias hms="home-manager switch"
    '';

  };
}

#what does // {} mean in nix
#In the Nix expression language, which is used for package management in NixOS and other systems that utilize the Nix package manager, `//` is the update operator. It is used to merge two sets (which are similar to dictionaries or maps in other languages) together. When you use `//`, the set on the right side will merge with the set on the left side, with the right side taking precedence in case of overlapping keys.
#
#Here's an example:
#
#```nix
#let
#  set1 = { a = 1; b = 2; };
#  set2 = { b = 3; c = 4; };
#in
#  set1 // set2
#```
#
#The result of this operation would be a new set:
#
#```nix
#{ a = 1; b = 3; c = 4; }
#```
#
#As you can see, the value of `b` in `set1` (which is `2`) has been overridden by the value of `b` in `set2` (which is `3`).
#
#The `{}` on its own represents an empty set. So if you see `// {}` in a Nix expression, it means that the set on the left side is being merged with an empty set, which effectively means that the left set remains unchanged because there are no values in the empty set to override it. It's essentially a no-op in terms of set contents, but it can be used to ensure that the result is always a set, or for syntactical reasons in more complex expressions.
