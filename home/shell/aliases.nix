let
  #openai_api_key="OPENAI_API_KEY=$(op read op://Personal/openai-secret/password)";
  openai_api_key="set OPENAI_API_KEY $(op read op://Personal/openai-secret/password)";
  signin="eval $(op signin)";
in
{
  ports="lsof -i -P -n";
  port-kill="kill $(lsof -t -i:4369)";

  # Monitoring Commands: `monitor-*`
  monitor="btop";
  monitor-containers="lazydocker";
  monitor-wifi="wavemon";

  #CMD_MOVIE="ssh -o StrictHostKeyChecking=no watch.ascii.theater";
  garbage-collect="nix-collect-garbage";
  flake-move-out="mv flake.nix flake.lock ~/";
  flake-move-in="mv ~/flake.nix ~/flake.lock ./";
  flake-hide="git add --intent-to-add flake.nix flake.lock && git update-index --assume-unchanged flake.nix flake.lock";

  #CMD_BS="echo ':terminal' | nvim -s --listen /tmp/$(tmux display-message -p '#S').pipe";

  # TODO - probably needs smarter pathing
  #CMD_ASSISTANT="${openai_api_key} && chat-beta || ${signin} && ${openai_api_key} && chat-beta";
  #CMD_CODE_GEN="${openai_api_key} && code";
  #CMD_ASK_JEEVES="${openai_api_key} && chat";
}

