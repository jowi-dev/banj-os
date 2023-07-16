# My Dev Environment

## Foreward
### This was a giant waste of time

I stand by it, but also now its a great way to have a completely portable env, that's pretty cool too.

If you, like me, are also interested in an metaphorical code gardening project - Nix + tmux + Neovim will certainly keep you busy. Feel free to give it a try.



## Setup


#### Prerequisites
**This has been tested on: Windows(WSL ONLY), Mac, Linux(PopOS/Debian). Use on other machines at your own risk. If you're thinking about trying to use this on Windows without WSL.. in the words of Obi Wan: "Don't try it Anakin"**

This is built on [Nix](https://nix.dev/tutorials/install-nix) and [Home Manager](https://nix-community.github.io/home-manager/). 

As of right now Nix version 2.13.3 is the newest stable version. [Related Issue](https://github.com/NixOS/nix/issues/7937#issuecomment-1451293677) and save yourself headache.

**The setup script will handle installing both of these for you, as well as configuring the environment for your local needs.**

TODO (WSL) - make an option that chooses the correct path to export so single user installation (Nix WSL recommendation) works out of the box. Build this into `setup.sh`


#### Steps
1. Make `setup.sh` executable
2. $ `./setup.sh`
3. `nvim` then `:checkhealth` to ensure everything is in working order







## Roadmap


### Nix Related Conversions

#### Blocking from Adoption for Work Laptop
- [x] tmux setup via nix
    * This includes setting it up to run without the tmux package manager
- [x] zsh setup via nix
    * Possibly a switch to toggle between bash/zsh at home/work
- [ ] Nerdfonts installation 



#### Nice to haves/easy setups
- [x] bash setup via nix
- [x] alacritty setup via nix
- [x] starship setup via nix
- [ ] ~erlang wxwidgets setup for erlang debugger/process viewer tools?~
    - skipping this because elixir supports DAP now so i really don't care about java nonsense



### Tooling Improvements

#### Other Tooling
- [ ] [Simulators for Mobile Dev](https://github.com/dimaportenko/telescope-simulators.nvim)
    * This will likely be a breaking point on needing to understand env vars in Nix. isMac/isLinux so linux installs don't get cluttered w/ iOS emulators they can't run
- [ ] Is there a way to have a browser window in the terminal so alt tabbing isn't needed for client side dev?
    * LOL [lynx](https://search.nixos.org/packages?channel=22.11&show=lynx&from=0&size=50&sort=relevance&type=packages&query=lynx)
- [ ] htop/performance monitors? How can these be integrated effectively into the workflow? Monitoring is still a big miss in my local dev flow
    * Maybe as a lualine indicator? Maybe as a disposable/composable vim buffer?
    * ctop as well
    * DTOP AS WELL TIPPY TOP
- [ ] NGNIX is likely gonna be helpful
- [ ] A rest/GQL testing tool would be amazing
- [ ] Any worthwhile docker tooling to have?
    * This is likely unnecessary and better of deleted
    * ctop
- [x] Something to help with markdown
    * vim-markdown removed for now, maybe consider [a new plugin](https://github.com/iamcco/markdown-preview.nvim)



### Neovim Related
- [ ] setup [Neomux](https://github.com/nikvdp/neomux)
    - tmux isn't windows compatible, and this is a step towards being windows compat
- [ ] setup [Session Manager](https://github.com/Shatur/neovim-session-manager)
    - again, the less tmux we have the less weird errors that come from switches. 
- [x] Test command for running tests in a new tmux split window, so we don't have to keep typing MIX_ENV=test mix test.....
- [ ] Also include a command to close said tmux split quickly
- [ ] @aruder's get github link for current file command
- [ ] ctags setup cross platform -> integrate setup into nvim for tag usage
- [ ] Determine if its worth moving from Ultisnips -> [Luasnips](https://github.com/L3MON4D3/LuaSnip)
    * This is likely pointless but it saves scripting from needing to be done in Python
- [ ] Remove org dependent snippets and replace with intelligent lookups
    * e.g. `PapaPal` shouldn't need to be in this repo - make the snippet grab the project name from mix.exs
- [ ] setup [DAP](https://github.com/mfussenegger/nvim-dap)
    * Consider [Plugins](https://github.com/mfussenegger/nvim-dap/wiki/Extensions) for DAP
- [ ] setup cpp tooling
    * This is likely going to be an easy find via @fmoda3's nixconfig (Acknowledgements)


### Tangential Project Ideas
- [ ] Once ctags is setup, complete TagStack, migrate to new repo
- [ ] Maybe its time to start considering having a command reference UI?
    * Maybe [cheatsheet](https://github.com/sudormrfbin/cheatsheet.nvim) as a start? Seems bloated
- [ ] Create a way to quickly grep/add/edit your knowledge base stored in logs/ so that you can reference it as needed.




## Bored?
Have a look at [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim) to get some inspiration.

## Acknowledgements
> This Nix config was heavily inspired by https://github.com/fmoda3/nix-configs/tree/master/home. If you're here to setup you're own config,  you should really consider looking at @fmoda3's first.






