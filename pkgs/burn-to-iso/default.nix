# nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'

{ stdenv, pkgs, lib, makeWrapper, ... }:
stdenv.mkDerivation {
  pname = "burn-to-iso";
  version = "1.0.0";
  src = ./script;
  buildInputs = [
    pkgs.gum
    pkgs.nixos-generators
  ];
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp burn-to-iso.sh $out/bin/burn-to-iso
    wrapProgram $out/bin/burn-to-iso \
      --prefix PATH : ${lib.makeBinPath [ pkgs.gum pkgs.nixos-generators ]}
  '';
}
