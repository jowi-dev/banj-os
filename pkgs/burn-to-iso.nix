{ nixpkgs  }:
nixpkgs.writeShellApplication {

  name = "burn-to-iso";
  runtimeInputs = [gum nixos-generators util-linux uutils-coreutils-noprefix];

  text = ''
    device = gum choose $(lsblk --noheadings -o NAME)
    sudo umount $device
    burn_new = gum confirm "Burn new ISO?" && true || false
    iso = ../result/iso/$iso_choice
    if [ burn_new ]; then
      nixos-generate -f iso --flake ../

    fi

    gum confirm "Burn $iso to $device ?" && gum spin --spinner dot -title "Burning to $device" -- sudo dd bs=4M if=$iso of=$device status=progress oflag=sync || echo "Discarded iso"

  '';
}
