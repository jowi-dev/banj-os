# Notes

## Steps leading to this being run
- Repo cloned to ~/.config/nixpkgs on target machine
- make setup.sh executable

## Actions to be taken
- Nix 2.13 installed
- NIX_PATH Variable set so nix commands can be executed
- Home Manager Installed via standalone installation instructions for 22.11
- ENV VARS SETUP VIA PROMPTS (next section)
- `home-manager switch` to activate the profile
- Some sort of success message?

## Env Vars tracked
- Github email
- github username
- home directory
- home username
- Operating System -- **Is there a way to get this automatically? Otherwise use a select**
- OpenAI API Key -- **Make Optional**
- SSH Key Gen? -- **Optional - Can this be added to clipboard after creation?**
