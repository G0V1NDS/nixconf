#
#  flake.nix *
#   ├─ ./hosts
#   │   └─ default.nix
#   ├─ ./darwin
#   │   └─ default.nix
#   └─ ./nix
#       └─ default.nix
#

{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs =                                                                  # References Used by Flake
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";                     # Nix Packages (Default)
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";         # Unstable Nix Packages
      nixos-hardware.url = "github:nixos/nixos-hardware/master";            # Hardware Specific Configurations

      home-manager = {                                                      # User Environment Manager
        url = "github:nix-community/home-manager/release-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      home-manager-unstable = {                                             # Unstable User Environment Manager
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

      darwin = {                                                            # MacOS Package Management
        url = "github:lnl7/nix-darwin/master";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

      nur = {                                                               # NUR Community Packages
        url = "github:nix-community/NUR";                                   # Requires "nur.nixosModules.nur" to be added to the host modules
      };

      firefox-addons = {
        url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixgl = {                                                             # Fixes OpenGL With Other Distros.
        url = "github:guibou/nixGL";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixvim = {                                                            # Neovim
        url = "github:nix-community/nixvim/nixos-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixvim-unstable = {                                                            # Neovim
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

      emacs-overlay = {                                                     # Emacs Overlays
        url = "github:nix-community/emacs-overlay";
        flake = false;
      };

      doom-emacs = {                                                        # Nix-Community Doom Emacs
        url = "github:nix-community/nix-doom-emacs";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.emacs-overlay.follows = "emacs-overlay";
      };

      hyprland = {                                                          # Official Hyprland Flake
        url = "github:hyprwm/Hyprland";                                     # Requires "hyprland.nixosModules.default" to be added the host modules
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };

      plasma-manager = {                                                    # KDE Plasma User Settings Generator
        url = "github:pjones/plasma-manager";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "nixpkgs";
      };
      # secrets = {
      #   url = "git+ssh://git@github.com/G0V1NDS/nix-secrets";
      #   inputs.nixpkgs.follows = "nixpkgs";
      #   # inputs.agenix.follows = "agenix";
      #   # inputs.flake-utils.follows = "utils";
      # };
    };

  # outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, home-manager-unstable, darwin, nur, nixgl, nixvim, nixvim-unstable, doom-emacs, hyprland, plasma-manager, secrets, ... }:   # Function telling flake which inputs to use
  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, home-manager-unstable, darwin, nur, nixgl, nixvim, nixvim-unstable, doom-emacs, hyprland, plasma-manager, ... }:   # Function telling flake which inputs to use
    let
      vars = {                                                              # Variables Used In Flake
        user = "guru";
        location = "$HOME/.setup";
        terminal = "kitty";
        editor = "nvim";
      };
    in
    {
      nixosConfigurations = (                                               # NixOS Configurations
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable nixos-hardware home-manager nur nixvim doom-emacs hyprland plasma-manager vars;   # Inherit inputs
        }
      );

      darwinConfigurations = (                                              # Darwin Configurations
        import ./darwin {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs-unstable home-manager-unstable darwin nixvim-unstable vars;
        }
      );

      homeConfigurations = (                                                # Nix Configurations
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager nixgl vars;
        }
      );
    };
}
