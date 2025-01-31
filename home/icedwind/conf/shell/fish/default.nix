{ config, colors, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      la = "run exa -l";
      ls = "ls --color=auto -a";
      v = "nvim";
      nf = "run neofetch";
      sa = "pkill ags ; ags & disown";
      suda = "sudo -E -s";
      sh = "swayhide";
      mnt = "sudo mount /dev/sdb5 ~/disks/hdd; sudo mount /dev/sda2 ~/disks/arch";

      hm = "home-manager switch --flake ~/Documents/nix-config/#icedwind@frostbyte";
      nx = "sudo nixos-rebuild switch --flake ~/Documents/nix-config/#frostbyte";
    };
    /*plugins = [
      # Enable a plugin (here grc for colorized command output) from nixpkgs
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      # Manually packaging and enable a plugin
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
    ];*/
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration\n[ ](fg:blue)  ";
      git_branch.format = "via [$symbol$branch(:$remote_branch)]($style) ";
      command_timeout = 1000;
    };
  };
}
