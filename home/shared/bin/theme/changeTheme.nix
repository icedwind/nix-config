_:
''
  #!/usr/bin/env sh
  THEME=$1
  hname=$(hostname)
  notify-send "Changing Theme" "Setting theme to $1"
  sed -i "/colors = import*/c\  colors = import ../shared/cols/$THEME.nix { };" /home/icedwind/Documents/nix-config/home/icedwind/home.nix
  home-manager switch -b backup --flake  /home/icedwind/Documents/nix-config#icedwind@$hname --keep-going
  echo $THEME > /tmp/themeName
  notify-send "Changing Theme Complete" "Current theme is now $1"
  kill -USR1 $(pidof st)
  #awesome-client 'awesome.emit_signal("colors::refresh")'
''
