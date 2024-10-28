{ stdenv
}:

stdenv.mkDerivation {
  pname = "dwm.tmux";
  version = "v0.5";

  src = fetchTarball {
    url = "https://github.com/alxlu/dwm.tmux/releases/download/0.1.1/dwm.tmux.tar.gz";
    sha256 = "0hhwwx6zjkjvz762fvjv9f9rb9bj275ny3dsw434si87hm7cifcc";
  };

  buildPhase = ''
    make PREFIX=$out BINDIR=$out/bin LIBDIR=$out/lib
  '';

  installPhase = ''
    make PREFIX=$out BINDIR=$out/bin LIBDIR=$out/lib install
  '';
}
