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



## Acknowledgements
> This Nix config was heavily inspired by https://github.com/fmoda3/nix-configs/tree/master/home.  

> Thank you very much to Nobbz, who was an invaluable resource learning nix
