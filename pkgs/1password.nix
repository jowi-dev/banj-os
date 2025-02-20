/* copy from nixpkgs but updated to fix arm64 support */
{ config, lib, currentSystem, stdenv, fetchzip, autoPatchelfHook, fetchurl, xar, cpio }:
stdenv.mkDerivation rec {
  pname = "1password";
  version = "2.24.0";
  src =
    if stdenv.isLinux then
      fetchzip
        {
          url = {
            "i686-linux" = "https://cache.agilebits.com/dist/1P/op2/pkg/v${version}/op_linux_386_v${version}.zip";
            "x86_64-linux" = "https://cache.agilebits.com/dist/1P/op2/pkg/v${version}/op_linux_amd64_v${version}.zip";
            "aarch64-linux" = "https://cache.agilebits.com/dist/1P/op2/pkg/v${version}/op_linux_arm64_v${version}.zip";
          }.${stdenv.hostPlatform.system};
          sha256 = {
            "i686-linux" = "0000000000000000000000000000000000000000000000000000";
            "x86_64-linux" = "sha256-hgMZ3gSqpb04ixTwMnEg0EpYgzuTF1CMEGGl6LbYKjY=";
            "aarch64-linux" = "0000000000000000000000000000000000000000000000000000";
          }.${stdenv.hostPlatform.system};
          stripRoot = false;
        } else
      fetchurl {
        url = "https://cache.agilebits.com/dist/1P/op/pkg/v${version}/op_apple_universal_v${version}.pkg";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };

  buildInputs = lib.optionals stdenv.isDarwin [ xar cpio ];

  unpackPhase = lib.optionalString stdenv.isDarwin ''
    xar -xf $src
    zcat op.pkg/Payload | cpio -i
  '';

  installPhase = ''
    install -D op $out/bin/op
  '';

  dontStrip = stdenv.isDarwin;

  nativeBuildInputs = lib.optionals stdenv.isLinux [ autoPatchelfHook ];

  doInstallCheck = true;

  installCheckPhase = ''
    $out/bin/op --version
  '';

  meta = with lib; {
    description = "1Password command-line tool";
    homepage = "https://support.1password.com/command-line/";
    downloadPage = "https://app-updates.agilebits.com/product_history/CLI";
    maintainers = with maintainers; [ joelburget marsam ];
    license = licenses.unfree;
    platforms = [ "i686-linux" "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
  };
}
