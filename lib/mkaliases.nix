let
  inherit (import ../home/shell/darwin-aliases.nix) makeDarwinAliases;
  inherit (import ../home/shell/linux-aliases.nix) makeLinuxAliases;
  genericAliases = import ../home/shell/aliases.nix;
in {
  mkaliases = { mac, homeDir, toolDir }:
    if mac then
      genericAliases // makeDarwinAliases "${homeDir}${toolDir}"
    else
      genericAliases // makeLinuxAliases "${homeDir}${toolDir}";
}
