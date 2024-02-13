{
  makeDarwinAliases = toolingDir: {
    rebuild = "darwin-rebuild switch --flake ${toolingDir}/.#papa-laptop";
  };
}
