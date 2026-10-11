{ lib, stdenvNoCC, fetchFromGitHub, makeWrapper, tmux }:

stdenvNoCC.mkDerivation {
  pname = "dwm.tmux";
  version = "unstable-2026-10-11";

  src = fetchFromGitHub {
    owner = "alxlu";
    repo = "dwm.tmux";
    rev = "96e60ea5d07c6c6aa81c7220e50b27019bfc1481";
    hash = "sha256-puf9xQDYm+9DFmoLxttfpxjtM10TszQ99FnRRdGVCME=";
  };

  dontBuild = true;
  nativeBuildInputs = [ makeWrapper ];
  installFlags = [ "PREFIX=$(out)" ];

  postInstall = ''
    wrapProgram "$out/share/dwm.tmux/dwm.tmux" \
      --prefix PATH : ${lib.makeBinPath [ tmux ]}
    wrapProgram "$out/share/dwm.tmux/bin/dwm.tmux" \
      --prefix PATH : ${lib.makeBinPath [ tmux ]}
  '';

  meta = {
    description = "dwm-inspired tiling pane management for tmux";
    homepage = "https://github.com/alxlu/dwm.tmux";
    mainProgram = "dwm.tmux";
    platforms = lib.platforms.unix;
  };
}
