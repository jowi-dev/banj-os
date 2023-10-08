# My Dev Environment

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











## Bored?

Have a look at [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim) to get some inspiration.

## Acknowledgements
> This Nix config was heavily inspired by https://github.com/fmoda3/nix-configs/tree/master/home. If you're here to setup you're own config,  you should really consider looking at @fmoda3's first.







