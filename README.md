# This was a giant waste of time
I'm now committed to it, like a toxic girl. Nix is the one for me.
Nvim is the one for me

Where is my clown mask. I like my dev tooling like I like my women. High maintenance and providing very little in return for it.

## Setup
This is built on [Nix](https://nix.dev/tutorials/install-nix) and [Home Manager](https://nix-community.github.io/home-manager/). Please make sure they are both installed before proceeding

Clone the contents of this repo into your `~/.config/nixpkgs/` directory

## Roadmap

### Nix Related Conversions

#### Blocking from Adoption for Work Laptop
- [ ] tmux setup via nix
    * This includes setting it up to run without the tmux package manager
- [ ] zsh setup via nix
- [ ] Nerdfonts installation 

#### Other Tooling
- [ ] [Simulators for Mobile Dev](https://github.com/dimaportenko/telescope-simulators.nvim)
    * This will likely be a breaking point on needing to understand env vars in Nix. isMac/isLinux so linux installs don't get cluttered w/ iOS emulators they can't run
- [ ] Is there a way to have a browser window in the terminal so alt tabbing isn't needed for client side dev?
- [ ] htop/performance monitors? How can these be integrated effectively into the workflow? Monitoring is still a big miss in my local dev flow
    * Maybe as a lualine indicator? Maybe as a disposable/composable vim buffer?
- [ ] Any worthwhile docker tooling to have?
    * This is likely unnecessary and better of deleted

#### Nice to haves/easy setups
- [ ] bash setup via nix
- [ ] alacritty setup via nix
- [ ] starship setup via nix
- [ ] erlang wxwidgets setup for erlang debugger/process viewer tools?

### Neovim Related
- [ ] Test command for running tests in a new tmux split window, so we don't have to keep typing MIX_ENV=test mix test.....
- [ ] Also include a command to close said tmux split quickly
- [ ] ctags setup cross platform -> integrate setup into nvim for tag usage
- [ ] Determine if its worth moving from Ultisnips -> [Luasnips](https://github.com/L3MON4D3/LuaSnip)
    * This is likely pointless but it saves scripting from needing to be done in Python
- [ ] Remove org dependent snippets and replace with intelligent lookups
    * e.g. `PapaPal` shouldn't need to be in this repo - make the snippet grab the project name from mix.exs
- [ ] setup [DAP](https://github.com/mfussenegger/nvim-dap)
    * Consider [Plugins](https://github.com/mfussenegger/nvim-dap/wiki/Extensions) for DAP
- [ ] setup cpp tooling
    * This is likely going to be an easy find via @fmoda3's nixconfig (Acknowledgements)

### Moonshots
- [ ] Once ctags is setup, complete TagStack, migrate to new repo


### Acknowledgements
> This Nix config was heavily inspired by https://github.com/fmoda3/nix-configs/tree/master/home. If you're here to setup you're own config,  you should really consider looking at @fmoda3's first.
