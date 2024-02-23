{ config, pkgs, currentSystem, ... }: {
  programs = {
    git = {
      enable = true;
      userName = currentSystem.git.username;
      userEmail = currentSystem.git.email;

      aliases = { };

      extraConfig = {
        advice = { statusHints = true; };

        apply = { whitespace = "nowarn"; };

        branch = { autosetupmerge = true; };

        color = {
          ui = true;
          status = true;
          interactive = true;
        };

        "color \"branch\"" = {
          current = "yellow reverse";
          local = "yellow";
          remote = "green";
        };

        "color \"diff\"" = {
          meta = "yellow bold";
          frag = "magenta bold";

          old = "red";
          new = "green";
        };

        core = {
          autocrlf = false;
          editor = "vim";
        };

        diff = {
          mnemonicprefix = true;
          algorithm = "patience";
        };

        format = {
          pretty =
            "format:%C(blue)%ad%Creset %C(yellow)%h%C(green)%d%Creset %C(blue)%s %C(magenta) [%an]%Creset";
        };

        merge = {
          conflictstyle = "diff3";
          summary = true;
          verbosity = 1;
        };

        mergetool = { prompt = false; };

        pull = { ff = "only"; };

        push = { default = "tracking"; };

        rerere = { enabled = true; };
      };

      delta = {
        enable = true;
        options = {
          commit-decoration-style = "bold box ul";
          dark = true;
          file-decoration-style = "none";
          file-style = "omit";
          hunk-header-decoration-style = ''"#88C0D0" box ul'';
          hunk-header-file-style = "white";
          hunk-header-line-number-style = ''bold "#5E81AC"'';
          hunk-header-style = "file line-number syntax";
          line-numbers = true;
          line-numbers-left-style = ''"#88C0D0"'';
          line-numbers-minus-style = ''"#BF616A"'';
          line-numbers-plus-style = ''"#A3BE8C"'';
          line-numbers-right-style = ''"#88C0D0"'';
          line-numbers-zero-style = "white";

          minus-emph-style = ''syntax bold "#780000"'';
          minus-style = ''syntax "#400000"'';
          plus-emph-style = ''syntax bold "#007800"'';
          plus-style = ''syntax "#004000"'';
          whitespace-error-style = ''"#280050" reverse'';
          zero-style = "syntax";
          syntax-theme = "Nord";
        };

      };

      ignores = [
        # macOS
        ".DS_Store"
        "._*"
        ".Spotlight-V100"
        ".Trashes"

        # Windows
        "Thumbs.db"
        "Desktop.ini"
      ];

    };
  };
}
