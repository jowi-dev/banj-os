{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      nord
    ];
    terminal = "screen-256color";
    escapeTime = 10;
    keyMode = "vi";
    extraConfig =
      let
        sessionVars = builtins.attrNames config.home.sessionVariables;
        envStr = builtins.concatStringsSep " " sessionVars;
        debugged = builtins.trace "Session variables: ${envStr}" envStr;
      in
      ''
        set-window-option -g mode-keys vi
        set-option -sa terminal-overrides ',xterm-256color:RGB'
        set -g update-environment "${debugged}"
      '';
  };
}
