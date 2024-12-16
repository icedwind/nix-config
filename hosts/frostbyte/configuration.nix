# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  #flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  my-python-packages = ps: with ps; [
    material-color-utilities
    numpy
    i3ipc
  ];
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../shared
    ];

  networking.hostName = "frostbyte"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  nixpkgs = {
    overlays = [
      #outputs.overlays.modifications
      #outputs.overlays.additions
      inputs.nixpkgs-f2k.overlays.stdenvs
      inputs.nixpkgs-f2k.overlays.compositors
      inputs.nur.overlays.default
      (final: prev:
        {
          awesome = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;
        })
    ];
    config = {
      allowUnfreePredicate = _: true;
      allowUnfree = true;
    };
  };

  programs.kdeconnect.enable = true;



  # List packages installed in system profile. To search, run:
  # $ nix search wget
  /*environment.systemPackages = with pkgs; [
     vim
     wget
     inputs.zen-browser.packages."${system}".generic
     vesktop
     ntfs3g

     steam-run
     appimage-run
     fuse
     nix-ld

     btop
     htop

     lm_sensors

     fastfetch
     neofetch
     pfetch

     home-manager

     android-tools

     godot_4-mono

     swaybg
     git
     ripgrep

     python3
     nodejs

     ags
  ];*/

  environment.systemPackages = with pkgs; [
    ags
    android-tools
    appimage-run
    btop
    bluez
    bluez-tools
    brillo
    brightnessctl
    dmenu
    direnv
    element-desktop
    eww
    fastfetch
    fuse
    git
    godot_4-mono
    gtk3
    home-manager
    htop
    imv
    #imgclr
    inotify-tools
    inputs.zen-browser.packages."${system}".generic
    jq
    libnotify
    lm_sensors
    lua-language-server
    lutgen
    maim
    mpv
    networkmanager_dmenu
    neofetch
    niv
    ntfs3g
    #osu-lazer
    pamixer
    pfetch
    pstree
    python3
    (pkgs.python311.withPackages my-python-packages)
    ripgrep
    #rnix-lsp
    st
    steam-run
    spotify
    slop
    simplescreenrecorder
    spotdl
    swaybg
    swaylock-effects
    udiskie
    unzip
    vesktop
    vim
    wget
    wirelesstools
    wmctrl
    xclip
    xdg-utils
    xorg.xorgserver
    xorg.xf86inputevdev
    xorg.xf86inputlibinput
    xorg.xf86inputsynaptics
    xorg.xf86videoati
    xorg.xwininfo
    xdotool
    nix-ld
    nix-prefetch-git

    #awesome
  ];

  /*services = {
    gvfs.enable = true;
    power-profiles-daemon.enable = false;
    tlp.enable = true;
    upower.enable = true;
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      windowManager.awesome = {
        enable = true;
      };
      desktopManager.gnome.enable = false;
    };

    libinput = {
        enable = true;
        touchpad = {
          tapping = true;
          middleEmulation = true;
          naturalScrolling = true;
        };
    };
    displayManager = {
      defaultSession = "none+awesome";
      startx.enable = true;
      sddm.enable = true;
    };
  }*/
  
  services.xserver.windowManager.awesome.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
