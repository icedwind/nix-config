{ colors, pkgs }: {
  programs.i3lock = with colors; {
    enable = true; # Important: Enable the module
    package = pkgs.i3lock-color;
    extraArgs = [
      "--clock"
      "--color" "00000000" # Transparent background
      "--font" "Product Sans"
      "--ring-color" "#${mbg}"
      "--keyhl-color" "#${accent}"
      "--text-color" "#${foreground}"
      "--inside-color" "#${background}"
      "--ring-ver-color" "#${accent}"
      "--inside-ver-color" "#${background}"
      "--ring-wrong-color" "#${color9}"
      "--inside-wrong-color" "#${background}"
      "--inside-clear-color" "#${background}"
      "--ring-clear-color" "#${color5}"
      "--bs-hl-color" "#${accent}"
      "--date-format" "%d.%m"
      "--verif-color" "#${accent}" # Added verification color
      "--wrong-color" "#${color9}" # Added wrong password color
      "--clear-color" "#${color5}" # Added clear color
    ];

    # These are harder to translate directly and might require scripting
    # i3lock doesn't have direct equivalents for:
    # - indicator-radius/thickness: i3lock's ring is fixed size.
    # - line-color/line-ver-color/line-wrong-color/line-clear-color: i3lock draws a single ring.
    # - show-failed-attempts: i3lock doesn't have this built-in.
    # - text-caps-lock-color: Not directly supported.
    # - grace/grace-no-mouse/grace-no-touch: Not directly supported.
        # - fade-in: i3lock doesnt support this.
        # - ignore-empty-password: i3lock doesnt support this.
    # If you really need these features, you'd likely have to write a wrapper script.
    # Example for using a custom script:
    # enable = false;
    # package = null;
    # script = pkgs.writeShellScriptBin "my-i3lock" ''
    #   i3lock --clock ... # your i3lock options
    #   # Add custom logic here, e.g., for showing failed attempts
    # '';
  };
}
