{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      #sensible
      nord
    ];
    terminal = "screen-256color";
    escapeTime = 10;
#    #shortcut = "a";
#    baseIndex = 1;
#    #keyMode = "vi";
#    historyLimit = 10000;
#    customPaneNavigationAndResize = true;
#    resizeAmount = 5;
#
#
#    extraConfig = ''
#      # splitting panes
#      # START:panesplit
##      bind | split-window -h
##      bind - split-window -v
#      # END:panesplit
#      # Quick pane selection
#      # START:panetoggle
##      bind -r C-h select-window -t :-
##      bind -r C-l select-window -t :+
#      # END:panetoggle
#      # mouse support - set to on if you want to use the mouse
#      # START:mouse
#      setw -g mouse off 
#      # END:mouse
#      # enable activity alerts
#      #START:activity
#      setw -g monitor-activity on
#      set -g visual-activity on
#      setw -g window-status-activity-style none
#      #END:activity
#      # Ring the bell if any background window rang a bell
#      set -g bell-action any
#      # Keep your finger on ctrl, or don't
#      #bind-key ^D detach-client
#      # easily toggle synchronization (mnemonic: e is for echo)
#      # sends input to all panes in a given window.
#      #bind e setw synchronize-panes
#      # color scheme (styled as vim-powerline)
#      set -g status-left-length 52
#      set -g status-right-length 451
#      # Screen like binding for last window
#      #bind C-a last-window
#      # Log output to a text file on demand
#      # START:pipe-pane
##      bind P pipe-pane -o "cat >>~/#W.log" \; display "Toggled logging to ~/#W.log"
#      # END:pipe-pane
#      # Neovim color compatibility
#      set-option -sa terminal-overrides ',xterm-256color:RGB'
#      # Auto rename windows to directory
#      set-option -g automatic-rename on
#      set-option -g automatic-rename-format '#{b:pane_current_path}'
#    '';
  };
}
