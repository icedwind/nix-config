{ config }:

{
  home.file.".config/fastfetch/config.jsonc".text = ''
    // Inspired by Catnap
    {
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
        "logo": {
            "type": "sixel",
            "source": "/home/icedwind/Documents/nix-config/home/images/misc/fastfetch.png",
            "height": 10,
            //"width": 30,
            "padding": {
                "top": 1,
            },
        },
        "display": {
            "separator": " "
        },
        "modules": [
            "title",
            {
                "key": "╭───────────╮",
                "type": "custom"
            },
            //{
            //    "key": "│ {#31} user    {#keys}│",
            //    "type": "title",
            //    "format": "{user-name}"
            //},
            //{
            //    "key": "│ {#32}󰇅 hname   {#keys}│",
            //    "type": "title",
            //    "format": "{host-name}"
            //},
            {
                "key": "│ {#34}{icon}  distro {#keys}│",
                "type": "os"
            },
            {
                "key": "│ {#35}  kernel {#keys}│",
                "type": "kernel"
            },
            {
                "key": "│ {#33}󰅐  uptime {#keys}│",
                "type": "uptime"
            },
            {
                "key": "│ {#36}󰇄  de     {#keys}│",
                "type": "de"
            },
            {
                "key": "│ {#36}  wm     {#keys}│",
                "type": "wm"
            },
            {
                "key": "│ {#31} term    {#keys}│",
                "type": "terminal"
            },
            {
                "key": "│ {#32}  shell  {#keys}│",
                "type": "shell"
            },
            {
                "key": "│ {#33}󰍛 cpu     {#keys}│",
                "type": "cpu",
                "showPeCoreCount": true
            },
            //{
            //    "key": "│ {#34}󰉉 disk    {#keys}│",
            //    "type": "disk",
            //    "folders": "/"
            //},
            {
                "key": "│ {#35}  memory {#keys}│",
                "type": "memory"
            },
            //{
            //    "key": "│ {#36}󰩟 network {#keys}│",
            //    "type": "localip",
            //    "format": "{ipv4} ({ifname})"
            //},
            {
                "key": "├───────────┤",
                "type": "custom"
            },
            {
                "key": "│ {#39}  colors {#keys}│",
                "type": "colors",
                "symbol": "circle"
            },
            {
                "key": "╰───────────╯",
                "type": "custom"
            }
        ]
    }
  '';
}


