final: prev:
{
  vimPlugins = prev.vimPlugins // {
    bash-gpt = prev.callPackage ./bash-gpt { };
  };
}
