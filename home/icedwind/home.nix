# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ...}:
let
  colors = import ../shared/cols/vixima.nix { };
  hyprland = inputs.hyprland;
  hyprland-plugins = inputs.hyprland-plugins;
in
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix

    # terminals
    (import ./conf/term/wezterm/default.nix { inherit pkgs colors inputs; })
    (import ./conf/term/kitty/default.nix { inherit pkgs colors; })


    # shells
    #(import ./conf/shell/zsh/default.nix { inherit config colors pkgs lib; })
    (import ./conf/shell/fish/default.nix { inherit config colors pkgs lib; })
    (import ./conf/shell/tmux/default.nix { inherit config colors pkgs lib; })

    # ui
    (import ./conf/ui/hyprland/default.nix { inherit config pkgs lib hyprland colors inputs; })
    (import ./conf/ui/waybar/default.nix { inherit config pkgs lib hyprland colors inputs; })

    # utils
    (import ./conf/utils/dunst/default.nix { inherit colors pkgs; })
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "icedwind";
    homeDirectory = "/home/icedwind";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName  = "icedwind";
    userEmail = "romaniv2.maximus@gmail.com";
  };

  # terminal emulators

  programs.kitty.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
