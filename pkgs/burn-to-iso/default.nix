# nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'

{ stdenv, pkgs, ... }:
  stdenv.mkDerivation {
    pname = "burn-to-iso";
    version = "1.0.0";
    src = ./script/burn-to-iso.sh;
    buildInputs = [ gum nixos-generators ];
    #nativeBuildInputs = [ makeWrapper ];
    installPhase = ''
      mkdir -p $out/bin
      cp burn-to-iso.sh $out/bin/burn-to-iso.sh
    '';
#      wrapProgram $out/bin/github-downloader.sh \
#        --prefix PATH : ${lib.makeBinPath [ bash subversion ]}
  }
