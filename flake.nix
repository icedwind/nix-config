
{
  description = "nixos config (yes)";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";
    nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zen
    zen-browser.url = "github:youwen5/zen-browser-flake";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    #darkmatter.url = "gitlab:VandalByte/darkmatter-grub-theme";

    #matugen = {
    #  url = "github:/InioX/Matugen";
    #};

    ignis.url = "github:linkfrg/ignis";

    wezterm.url = "github:wez/wezterm?dir=nix";

    hyprpanel.url = "github:jas-singhfsu/hyprpanel";

    dbus_proxy.url = "github:Kasper24/lua-dbus_proxy/custom";
    #hyprpanel.inputs.nixpkgs.follows = "nixpkgs";

    #stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    #stylix,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      frostbyte = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [./hosts/frostbyte/configuration.nix];
      };
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [./hosts/laptop/configuration.nix];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "icedwind@frostbyte" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [./home/icedwind/home.nix]; #  stylix.nixosModules.stylix
      };
    };
  };
}
