{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      nord
    ];
    terminal = "alacritty";
    shell = "${pkgs.fish}/bin/fish";
    #shell = "\${pkgs.fish}/bin/fish";
    mouse=true;
    escapeTime = 10;
    keyMode = "vi";
    extraConfig = ''
          set-window-option -g mode-keys vi
        '';
  };
}
