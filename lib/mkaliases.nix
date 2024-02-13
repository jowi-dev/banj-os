let 
  inherit (import ../env/default.nix) local-env;
  homeDirectory = local-env.homeDirectory;
  toolingDirectory = local-env.toolingDirectory;
  inherit (import ./get_system_type.nix) isMac;
  directory = "${homeDirectory}${toolingDirectory}";
  inherit (import ../home/shell/darwin-aliases.nix) makeDarwinAliases;
  inherit (import ../home/shell/linux-aliases.nix) makeLinuxAliases;
  genericAliases = import ../home/shell/aliases.nix ;
in 
{
  mkaliases = systemName: if isMac systemName then genericAliases // makeDarwinAliases directory else genericAliases // makeLinuxAliases directory;
}
