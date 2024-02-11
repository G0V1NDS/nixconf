#  Specific system configuration settings for MacBook 8,1
#
#  flake.nix
#   └─ ./darwin
#       ├─ default.nix
#       ├─ macbook.nix *
#       └─ ./modules
#           └─ default.nix
#
{ config, pkgs, vars, ... }: {
  imports = (import ./modules);

  users.users.${vars.user} = {
    # MacOS User
    home = "/Users/${vars.user}";
    shell = pkgs.zsh; # Default Shell
  };

  networking = {
    computerName = "MacBook"; # Host Name
    hostName = "MacBook";
  };

  skhd.enable = false; # Window Manager
  yabai.enable = false; # Hotkeys

  fonts = {
    # Fonts
    fontDir.enable = true;
    fonts = with pkgs; [
      source-code-pro
      font-awesome
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };

  environment = {
    shells = with pkgs; [ zsh ]; # Default Shell
    variables = {
      # Environment Variables
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [
      # System-Wide Packages
      # Terminal
      git
      ranger

      # Remote
      moonlight-qt
    ];
  };

  programs = {
    zsh.enable = true; # Shell
  };

  services = {
    nix-daemon.enable = true; # Auto-Upgrade Daemon
  };

  homebrew = {
    # Homebrew Package Manager
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    brews = [
      # "wireguard-tools"
    ];
    casks = [ "jellyfin-media-player" "plex-media-player" ];
  };

  nix = {
    package = pkgs.nix;
    gc = {
      # Garbage Collection
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };

  system = {
    # Global macOS System Settings
    defaults = {
      NSGlobalDomain = {
        # Whether to always show hidden files
        AppleShowAllFiles = true;
        # Whether to show all file extensions in Finder
        AppleShowAllExtensions = true;
        # Set to 'Dark' to enable dark mode, or leave unset for normal mode
        # AppleInterfaceStyle = "Dark";
        # Whether to automatically switch between light and dark mode
        AppleInterfaceStyleSwitchesAutomatically = false;
        # Whether to enable the press-and-hold feature
        ApplePressAndHoldEnabled = false;
        # Whether to enable "Natural" scrolling direction
        "com.apple.swipescrolldirection" = false;
        # Whether to animate opening and closing of windows and popovers
        NSAutomaticWindowAnimationsEnabled = false;
        # Whether to save new documents to iCloud by default
        NSDocumentSaveNewDocumentsToCloud = false;
        # Whether to enable the focus ring animation
        NSUseAnimatedFocusRing = false;
        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;
        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;
        # Configures the trackpad tap behavior.  Mode 1 enables tap to click.
        "com.apple.mouse.tapBehavior" = 1;
        # Sets the beep/alert volume level from 0.000 (muted) to 1.000 (100% volume)
        "com.apple.sound.beep.volume" = 0.0;
        # Make a feedback sound when the system volume changed. This setting accepts the integers 0 or 1. Defaults to 1.
        "com.apple.sound.beep.feedback" = 0;
        # Whether to autohide the menu bar
        _HIHideMenuBar = true;
      };
      # https://github.com/LnL7/nix-darwin/blob/master/modules/system/defaults/dock.nix
      dock = {
        # Position of the dock on screen, Values: bottom, left, right
        orientation = "bottom";
        autohide = true;
        # Sets the speed of the autohide delay
        autohide-delay = 0.0;
        # Sets the speed of the animation when hiding/showing the Dock
        autohide-time-modifier = 1.0;
        show-recents = false;
        # Animate opening applications from the Dock
        launchanim = false;
        tilesize = 32;
        showhidden = true;
        # Set the minimize/maximize window effect, values: genie, such, scale
        mineffect = "scale";
        # Enable highlight hover effect for the grid view of a stack in the Dock
        mouse-over-hilite-stack = false;
        # Whether to automatically rearrange spaces based on most recent use
        mru-spaces = false;
        # Whether to group windows by application in Mission Control's Exposé
        expose-group-by-app = false;

        ## Hot Corners
        ## Hot corner action valid values include:

        # * `1`: Disabled
        # * `2`: Mission Control
        # * `3`: Application Windows
        # * `4`: Desktop
        # * `5`: Start Screen Saver
        # * `6`: Disable Screen Saver
        # * `7`: Dashboard
        # * `10`: Put Display to Sleep
        # * `11`: Launchpad
        # * `12`: Notification Center
        # * `13`: Lock Screen
        # * `14`: Quick Note
        wvous-tl-corner = 2;
        wvous-tr-corner = 12;
        wvous-br-corner = 6;
        wvous-bl-corner = 3;
      };

      menuExtraClock = {
        ShowDayOfMonth = false;
        ShowDayOfWeek = false;
        # Show the full date. Default is null. 0 = Show the date, 1 = Don't show, 2 = Don't show
        ShowDate = 2;
        ShowSeconds = false;
      };

      finder = {
        AppleShowAllFiles = true;
        ShowStatusBar = true;
        ShowPathbar = true;
        _FXShowPosixPathInTitle = true;
        # Change the default finder view.
        # "icnv" = Icon view, "Nlsv" = List view, "clmv" = Column View, "Flwv" = Gallery View
        FXPreferredViewStyle = "Nlsv";
        # Whether to allow quitting of the Finder
        QuitMenuItem = true;
        # Whether to always show file extensions
        AppleShowAllExtensions = true;
      };

      screencapture.location =
        "${config.users.users.${user}.home}/Sync/Pictures";

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
    activationScripts.postActivation.text =
      "sudo chsh -s ${pkgs.zsh}/bin/zsh"; # Set Default Shell
    stateVersion = 4;
  };

  home-manager.users.${vars.user} = {
    home = { stateVersion = "22.05"; };

    programs = {
      zsh = {
        # Shell
        enable = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        history.size = 10000;

        oh-my-zsh = {
          # Plug-ins
          enable = true;
          plugins = [ "git" ];
          custom = "$HOME/.config/zsh_nix/custom";
        };

        initExtra = ''
          source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
          autoload -U promptinit; promptinit
        ''; # Theming
      };
    };
  };
}
