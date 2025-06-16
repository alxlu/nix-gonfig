{ config, pkgs, ... }:
let
  # Define dwm-tmux as a package once
  dwmTmux = pkgs.callPackage ./dwm-tmux.nix { };
  zeit = pkgs.callPackage ./zeit.nix { };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "alex";
    homeDirectory = "/Users/alex";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # installed to /etc/profiles/per-user/<user>/
  home.packages = with pkgs; [
    tmux
    vim
    dwmTmux
    swiftbar
    zeit
  ];
  home.file.".config/tmux/workspaces.tmux" = {
    source = ./tmux/workspaces.tmux;
    executable = true;
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
    ${builtins.readFile ./tmux/tmux.conf}
    source ${dwmTmux}/lib/dwm.tmux
    ${builtins.readFile ./tmux/style.conf}
    ${builtins.readFile ./tmux/bindings.conf}
    '';
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    # enableAutosuggestions = true;
    # enableCompletion = true;
    # syntaxHilighting = { enable = true; };
    initExtra = builtins.readFile ./zsh/zshrc;
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
