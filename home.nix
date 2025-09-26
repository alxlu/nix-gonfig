{ config, lib, pkgs, ... }:
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
    kubectl
  ];

  xdg.enable = true;

  xdg.configFile."tmux/tmux.conf".source = ./tmux/tmux.conf;
  xdg.configFile."tmux/dwm.tmux".source = "${dwmTmux}/lib/dwm.tmux";
  xdg.configFile."tmux/style.conf".source = ./tmux/style.conf;
  xdg.configFile."tmux/bindings.conf".source = ./tmux/bindings.conf;
  xdg.configFile."tmux/workspaces.tmux" = {
    source = ./tmux/workspaces.tmux;
    executable = true;
  };

  home.sessionVariables = {
    TMUX_PLUGIN_MANAGER_PATH = "${config.home.homeDirectory}/.local/share/tmux/plugins";
    XDG_CONFIG_HOME = lib.mkDefault "${config.home.homeDirectory}/.config";
  };

  programs.tmux = {
    enable = true;
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
