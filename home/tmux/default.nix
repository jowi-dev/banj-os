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
    extraConfig = ''
          set-window-option -g mode-keys vi
          set-option -sa terminal-overrides ',xterm-256color:RGB'
        '';
  };
}
