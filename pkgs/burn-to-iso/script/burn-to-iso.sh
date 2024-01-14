echo "Choose device to burn ISO to"
device=$(gum choose $(lsblk --noheadings -o NAME))
sudo umount /dev/$device
burn_new=$(gum confirm "Burn new ISO?" && gum spin --spinner dot --title "Generating ISO from nix config" -- nixos-generate -f iso --flake ~/.config/nix-config/ || echo "Skipping ISO creation")
# TODO - if more than one config is generated give a choose here
iso=~/.config/nix-config/result/iso/nixos.iso

gum confirm "Burn $iso to $device ?" && gum spin --spinner dot --title "Burning to $device" -- sudo dd bs=4M if=$iso of=/dev/$device status=progress oflag=sync || echo "Discarded iso"


