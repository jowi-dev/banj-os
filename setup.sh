#! /bin/bash

echo "Welcome to the Setup Wizard!"
# TODO - wsl.conf needs to be called out here
# TODO - home-manager needs to be cloned into ~/.config/home-manager with nix updates
read -p "Please ensure this repo was cloned to $HOME/.config/nixpkgs before continuing. Continue? (Y/n): " p1cont

if [ $p1cont == 'n' ] then 
  exit N 
fi

read -p "This will install Nix, Home manager, and a host of dev tools. Continue? (Y/n): " p2cont 
if [ $p2cont == 'n' ] then 
  exit N 
fi

curl -L https://releases.nixos.org/nix/nix-2.13.3/install | sh -s -- --daemon
nix_install=$(nix --version)

if [ ! nix_install == 'nix (Nix) 2.13.3' ] then
  exit $nix_install
fi

export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}

# Unstable Home Manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Unstable NixPkgs
nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
nix-channel --update



nix-shell '<home-manager>' -A install

echo "System Setup.."
sys_name=$(uname) # will be Darwin (mac) or Linux
user=$(id -un)
home=$(echo $HOME)


read -p "Enter username ($user): " usr_inp
if [ ! -z "$usr_inp" ] && [ $sys_name == 'Darwin' ]
then
  user=$usr_inp
  home="/Users/$user"
elif [ ! -z "$usr_inp" ] && [$sys_name == 'Linux' ] 
then
  user=$usr_inp
  home="/home/$user"
fi

# -p is prompt, -sp is silent prompt (for passwords)
read -p "Enter Home Directory ($home): " home_dir_inp

if [ ! -z "$home_dir_inp" ]; then
  home=$home_dir_inp
fi

echo home is $home


read -p "Enter Github Username: " git_user
echo git_user is $git_user

read -p "Enter Github Email: " git_email
echo git_email is $git_email

read -p "Enter OpenAPI Key: " open_api_key
echo key is $open_api_key

cat > env/default.nix << EOF
{
  imports = [
    ./defenv
  ];
  local-env = {
    username = "$user";
    homeDirectory = "$home";
    gitUserName = "$git_user";
    gitEmail = "$git_email";
    openAPIKey = "$open_api_key";
  };
}
EOF

read -p "Setup Almost Complete! Would you like to activate your Environment now? (Y/n): " p3cont

if [ $p1cont == 'n' ] then 
  exit N 
fi

home-manager switch

echo "Done! Be sure to setup your ssh key for your github account if you haven't already. Otherwise get coding with `nvim`."
