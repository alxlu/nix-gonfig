{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "zeit";
  src = pkgs.fetchurl {
    url = "https://github.com/mrusme/zeit/releases/download/v0.0.9/zeit_0.0.9_darwin_arm64.tar.gz";
    sha256 = "18hffb065yi2wsnn7h5p72100fa0j1yjby43x34aar09kpzs9m4m";
  };
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    tar xf $src
    cp zeit $out/bin/zeit
    chmod +x $out/bin/zeit
  '';
} 