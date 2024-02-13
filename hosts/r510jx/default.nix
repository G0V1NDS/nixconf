#
#  Specific system configuration settings for r510jx
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ ./r510jx
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       ├─ ./desktops
#       │   ├─ kde.nix
#       │   └─ ./virtualisation
#       │       └─ default.nix
#       └─ ./hardware
#           └─ ./r510jx
#               └─ default.nix
#

{ pkgs, vars, ... }:

{
  imports = [ ./hardware-configuration.nix ] ++
            ( import ../../modules/desktops/virtualisation ) ++
            ( import ../../modules/hardware/r510jx );

  boot = {                                      # Boot Options
    consoleLogLevel = 3;
    loader = {
      systemd-boot = {
          enable = true;
          configurationLimit = 2;
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = null;
    };
  };

  laptop.enable = true;                         # Laptop modules
  kde.enable = true;                            # Window manager

  environment = {
    systemPackages = with pkgs; [               # System Wide Packages
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      # ansible           # Automation
      # nil               # LSP
      # onlyoffice-bin    # Office
      # rclone            # Gdrive ($ rclone config | rclone mount --daemon gdrive: <mount> | fusermount -u <mount>)
      # simple-scan       # Scanning
      # sshpass           # Ansible dependency
      # wacomtablet       # Tablet
      # wdisplays         # Display Configurator
    ];
  };

  # programs.light.enable = true;                 # Monitor Brightness

  flatpak = {                                   # Flatpak Packages (see module options)
    extraPackages = [
      "com.github.tchx84.Flatseal"
    ];
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
