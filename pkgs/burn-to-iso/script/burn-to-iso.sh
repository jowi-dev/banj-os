  # TODO - if more than one config is generated give a choose here
HARDCODED_ISO_PATH=~/.config/nix-config/result/iso/nixos.iso


echo "Choose device to burn ISO to"
device=$(gum choose $(lsblk -p -S --noheadings -o NAME) "NONE")
if [ $device != "NONE" ]; then
  sudo umount $device

  gum confirm "Format USB Drive and clear contents?" && sudo mkfs.vfat -F 32 $device || echo "Skipping USB formatting"

  gum confirm "Burn new ISO?" && gum spin --spinner dot --title "Generating ISO from nix config" -- nixos-generate -f iso --flake ~/.config/nix-config/ || echo "Skipping ISO creation"

  gum confirm "Burn $HARDCODED_ISO_PATH to $device ?" && gum spin --spinner dot --title "Burning to $device" -- sudo dd bs=4M if=$HARDCODED_ISO_PATH of=$device status=progress oflag=sync || echo "Discarded iso"

else
  echo "No Flashable devices mounted."
fi
