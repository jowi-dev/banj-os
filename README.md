# My Dev Environment

## Elevator Pitch
You're an avid OSS contributer, with a day job. You have a work computer courtesy of your company and Apple, and a personal computer that's linux. You install a shiny new monitoring tool at home, then go to work and ... no surprises its not there. You install it manually at work. Rinse and repeat for every single tool, all 30 of them. You go on a job hunt, get a new mac, boom! All of that setup on your old work laptop is gone.

Wouldn't it be great to have a development environment that grows with you instead of holding you back? Docker is great and helps tremendously, but doesn't quite hit the bare metal audience as well as it could, so you're left with Nix. 

I think the tooling nix provides is unmatched in a lot of ways. There's no sugar coating the unwieldy learning curve, but there's no understating how nice it is to say `git pull && rebuild` to have a perfect 1:1 clone of your development environment between all your machines.


## Setup


#### Prerequisites
1. Install nix, enable flakes

#### Steps to install
1. Clone this repo
2. nixos-rebuild switch --flake 
3. `nvim` then `:checkhealth` to ensure everything is in working order


### Fresh machine setup 
1. Install Git & Add an SSH key that has access to this repo
  * Create Key `ssh-keygen -t ed25519 -C "your_email@example.com"`
  * Copy Key `pbcopy $(cat ~/.ssh/id_ed25519.pub)`
  * Add key to GH account
2. Install Nix, enable flakes
  * [Install](https://nixos.org/download/)
  * Enable Flakes `echo experimental-features=nix-command flakes > ~/.config/nix/nix.conf`
3. Clone this Repo 
4. `cd $THISREPO`
5. Look in `flake.nix` and decide on a system that fits your needs. **Generally speaking use nixos for linux or papa-laptop for mac.** These systems have been dogfooded for years.
#### Darwin
```
nix build .#darwinConfigurations.papa-laptop.system
./result/sw/bin/darwin-rebuild switch --flake .#papa-laptop
```
### NixOS
```
nix build ".#nixosConfigurations.nixos.system"
sudo ./result/sw/bin/nixos-rebuild switch --flake ".#nixos"
```
6. Restart your computer, open a terminal, type `nvim` and when nvim opens type `:checkhealth`. All plugins and language runtimes should be installed and ready to dev


## Acknowledgements
> This Nix config was heavily inspired by https://github.com/fmoda3/nix-configs/tree/master/home.  

> Thank you very much to Nobbz, who was an invaluable resource learning nix
