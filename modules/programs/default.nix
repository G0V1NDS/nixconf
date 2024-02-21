#
#  Apps
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ configuration.nix
#   └─ ./modules
#       └─ ./programs
#           ├─ default.nix *
#           └─ ...
#

[
  ./firefox.nix
  ./alacritty.nix
  ./eww.nix
  ./flatpak.nix
  ./kitty.nix
  ./obs.nix
  ./rofi.nix
  ./waybar.nix
  ./wofi.nix
  #./games.nix
]
