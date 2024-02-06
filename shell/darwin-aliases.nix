# TODO - mac aliases
{
  makeDarwinAliases = toolingDir: {
    switch = "darwin-rebuild switch --flake ${toolingDir}/.#papa-laptop";
  };
}
