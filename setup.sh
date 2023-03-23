#! /bin/bash

echo "Welcome to the Setup Wizard!"
echo "Please ensure this repo was cloned to $HOME/.config/nixpkgs before continuing"
# TODO: There should be a way to setup some sane defaults here given the system is known
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
echo home dir inp is $home_dir_inp

if [ -z "$home_dir_inp" ]; then
  home=home_dir_inp
fi

echo user is $user


#cat > env.nix <<EOF
#{ pkgs ? import <nixpkgs> {} }:
#with pkgs;
#{
#  environment.systemPackages = with pkgs; [
#    (python3.withPackages (ps: with ps; [ requests ]))
#  ];
#}
#EOF


