# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ...}:
let
  colors = import ../shared/cols/kizu.nix { };
  walltype = "image";
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
    (import ./conf/term/foot/default.nix { inherit colors; })


    # shells
    #(import ./conf/shell/zsh/default.nix { inherit config colors pkgs lib; })
    (import ./conf/shell/fish/default.nix { inherit config colors pkgs lib; })
    #(import ./conf/shell/tmux/default.nix { inherit config colors pkgs lib; })

    # ui
    (import ./conf/ui/hyprland/default.nix { inherit config pkgs lib hyprland colors inputs; })
    (import ./conf/ui/waybar/default.nix { inherit config pkgs lib hyprland colors inputs; })

    # utils
    (import ./conf/utils/dunst/default.nix { inherit colors pkgs; })
    (import ./conf/utils/rofi/default.nix { inherit config pkgs colors; })
    #(import ./conf/utils/swaylock/default.nix { inherit colors pkgs; })

    (import ./conf/utils/thunar/default.nix { inherit pkgs; })

    # hypr stuff
    (import ./conf/hypr/hyprlock/default.nix { inherit config lib colors; })
    (import ./conf/hypr/hypridle/default.nix { inherit pkgs; })

    # Some file generation
    (import ./misc/vencord.nix { inherit config colors; })
    (import ./misc/neofetch.nix { inherit config colors; })
    (import ./misc/xinit.nix { inherit colors; })
    (import ./misc/ewwags.nix { inherit config colors; })
    (import ./misc/obsidian.nix { inherit colors; })

    # Music thingies
    #(import ./conf/music/spicetify/default.nix { inherit colors inputs pkgs; })
    (import ./conf/music/mpd/default.nix { inherit config pkgs; })
    (import ./conf/music/ncmp/hypr.nix { inherit config pkgs; })
    (import ./conf/music/cava/default.nix { inherit colors; })

    # Bin files
    (import ../shared/bin/default.nix { inherit config colors walltype; })

    (import ./misc/fastfetch.nix { inherit config; })
    (import ./misc/ignis.nix { inherit config colors; })

    (import ./conf/editors/vscodium/default.nix { inherit pkgs colors; })
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

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    iconTheme.name = "Papirus";
    theme.name = "phocus";
  };

  home = {
    activation = {
        installConfig = ''
          if [ ! -d "${config.home.homeDirectory}/.config/awesome" ]; then
            ${pkgs.git}/bin/git clone --depth 1 --branch aura https://github.com/namishh/crystal ${config.home.homeDirectory}/.config/awesome
          fi
          if [ ! -d "${config.home.homeDirectory}/.config/eww" ]; then
            ${pkgs.git}/bin/git clone --depth 1 --branch glacier https://github.com/namishh/crystal ${config.home.homeDirectory}/.config/eww
          fi
          if [ ! -d "${config.home.homeDirectory}/.config/nvim" ]; then
            ${pkgs.git}/bin/git clone --depth 1 https://github.com/namishh/kodo ${config.home.homeDirectory}/.config/nvim
          fi
        '';
    };

    # Add stuff for your user as you see fit:
    # programs.neovim.enable = true;
    packages = with pkgs; [
      bc
      git-lfs
      feh
      wl-clipboard
      sway-contrib.grimshot
      trash-cli
      xss-lock
      #authy
      go
      gopls
      playerctl
      (pkgs.callPackage ../../pkgs/icons/papirus.nix { })
      (pkgs.callPackage ../../pkgs/others/phocus.nix { inherit colors; })

      nemo
      xfce.thunar

      i3lock-color
      rust-analyzer
      mpc-cli
      ffmpeg
      neovim
      libdbusmenu-gtk3
      xdg-desktop-portal
      imagemagick
      xorg.xev
      procps
      obsidian
      redshift
      killall
      moreutils
      wf-recorder
      mpdris2
      socat

      #inputs.matugen.packages.${system}.default
      #inputs.swayhide.packages.${system}.default

      pavucontrol
      fzf
      vesktop
      swww
      swayidle
      autotiling-rs
      pywal
      slurp
      sassc

      lua52Packages.lua-pam

      bibata-cursors
      hyprcursor

      wdisplays

      inputs.ignis.packages.${system}.ignis

      nitch
    ];
  };

  home.file.".wallpapers" = {
    source = ../images/walls;
    recursive = true;
  };

  home.sessionPath = [
    "/home/icedwind/.local/bin"
  ];

  programs.bun.enable = true;
  services.udiskie.enable = true;
  services.cliphist.enable = true;

  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName  = "icedwind";
    userEmail = "romaniv2.maximus@gmail.com";
  };


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
