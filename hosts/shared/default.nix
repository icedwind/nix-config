{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = false;

    efi.canTouchEfiVariables = true;

    grub.enable = true;
    grub.device = "nodev";
    grub.efiSupport = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  #programs.zsh.enable = true;
  programs.fish.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
    powerOnBoot = true;
  };


  services.blueman.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.icedwind = {
    isNormalUser = true;
    description = "icedwind";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  users.defaultUserShell = pkgs.fish;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    #clean.extraArgs = "--keep-since 4d --keep 3";
    clean.extraArgs = "--delete-older-than 5d";
    flake = "/home/icedwind/Documents/nix-config";
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
      warn-dirty = false;
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
    gc = {
      #automatic = true;
      options = "--delete-older-than 5d";
    };
    optimise.automatic = true;
  };

  fonts = {
    packages = with pkgs; [
      material-design-icons
      dosis
      material-symbols
      rubik
      noto-fonts-color-emoji
      google-fonts
      #(nerdfonts.override { fonts = [ "Iosevka" ]; })
      nerd-fonts.iosevka
      nerd-fonts.space-mono
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Product Sans" ];
        monospace = [ "Iosevka Nerd Font" ];
      };
    };

    enableDefaultPackages = true;
  };
}
