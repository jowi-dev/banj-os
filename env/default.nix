{
  imports = [
    ./defenv
  ];
  # Most of this can probably be moved into more
  # idiomatic nix config locations
  local-env = {
    username = "jowi";
    system = "x86_64-linux";
    homeDirectory = "/home/jowi";
    toolingDirectory = "/.config/nix-config";
    gitUserName = "jowi-dev";
    gitEmail = "joey8williams@gmail.com";
  };
}
