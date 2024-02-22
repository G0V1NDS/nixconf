#
#  Main system configuration. More information available in configuration.nix(5) man page.
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ configuration.nix *
#   └─ ./modules
#       ├─ ./desktops
#       │   └─ default.nix
#       ├─ ./editors
#       │   └─ default.nix
#       ├─ ./hardware
#       │   └─ default.nix
#       ├─ ./programs
#       │   └─ default.nix
#       ├─ ./services
#       │   └─ default.nix
#       ├─ ./shell
#       │   └─ default.nix
#       └─ ./theming
#           └─ default.nix
#

{ config, lib, pkgs, unstable, inputs, vars, ... }:

let
  terminal = pkgs.${vars.terminal};
in
{
  imports = ( import ../modules/desktops ++
              import ../modules/editors ++
              import ../modules/hardware ++
              import ../modules/programs ++
              import ../modules/services ++
              import ../modules/shell ++
              import ../modules/theming );

  boot = {
    tmp = {
      cleanOnBoot =  true;
      tmpfsSize = "5GB";
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${vars.user} = {              # System User
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" ];
    packages = with pkgs; [

    ];
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  fonts.packages = with pkgs; [                # Fonts
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome                            # Icons
    victor-mono
    corefonts                               # MS
    (nerdfonts.override {                   # Nerdfont Icons override
      fonts = [
        "FiraCode"
      ];
    })
  ];

  environment = {

    variables =
    let
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_BIN_HOME = "$HOME/.local/bin";
    in {
      XDG_CONFIG_HOME="${XDG_CONFIG_HOME}";
      XDG_DATA_HOME="${XDG_DATA_HOME}";
      XDG_CACHE_HOME="${XDG_CACHE_HOME}";
      XDG_BIN_HOME="${XDG_BIN_HOME}";

      TERMINAL = "${vars.terminal}";
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";

      ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc";
      ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf";
      ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/pip/default-python-packages";
      ASDF_NPM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/npm/default-npm-packages";
      ASDF_GEM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME}/gem/default-gems";

      GOPATH="${XDG_DATA_HOME}/go";
      GOBIN="$GOPATH/bin";
      GOTESTS_TEMPLATE="testify";

      NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch-config";
      GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0";
      LESSHISTFILE="-";
      WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc";
      INPUTRC="${XDG_CONFIG_HOME}/shell/inputrc";
      EDITRC="${XDG_CONFIG_HOME}/shell/editrc";
      ZDOTDIR="${XDG_CONFIG_HOME}/zsh";
      ANTIDOTE_HOME="${XDG_CACHE_HOME}/antidote";
      #export ALSA_CONFIG_PATH="$XDG_CONFIG_HOME/alsa/asoundrc"
      #export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
      WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/default";
      KODI_DATA="${XDG_DATA_HOME}/kodi";
      PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store";
      TMUX_TMPDIR="$XDG_RUNTIME_DIR";
      ANDROID_HOME="$HOME/Library/Android/sdk";
      ANDROID_SDK_HOME="$HOME/.android";
      # export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android";
      CARGO_HOME="${XDG_DATA_HOME}/cargo";
      ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible/ansible.cfg";
      UNISON="${XDG_DATA_HOME}/unison";
      HISTFILE="${XDG_DATA_HOME}/history";
      WEECHAT_HOME="${XDG_CONFIG_HOME}/weechat";
      GIT_HOME="${XDG_CONFIG_HOME}/git";
      AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials";
      AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config";
      GNUPGHOME="${XDG_CONFIG_HOME}/gnupg";
      PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonstartup.py";
      IPYTHONDIR="${XDG_CONFIG_HOME}/python/ipython";
      PYLINTHOME="${XDG_CACHE_HOME}/pylint";
      PYTHONHISTORY="${XDG_DATA_HOME}/python";
      RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/.ripgreprc";
      NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc";
      # export NPM_CONFIG_PREFIX="${XDG_DATA_HOME}/npm" # NVM doesn't support it
      NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history";
      npm_config_devdir="${XDG_CACHE_HOME}/node-gyp"; # For node-gyp
      RUSTUP_HOME="${XDG_CONFIG_HOME}/rustup";
      MYVIMRC="${XDG_CONFIG_HOME}/nvim/lua/init.lua";
      MYVIMRCLSP="${XDG_CONFIG_HOME}/nvim/lua/initlsp.lua";
      # NVM_DIR=''
      #   $([ -z "${XDG_CONFIG_HOME}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")
      # '';
      MBSYNCRC="${XDG_CONFIG_HOME}/isync/mbsyncrc";
      SVDIR="/run/runit/service";

      # Clipmenu
      CM_DEBUG="1";
      CM_DIR="${XDG_DATA_HOME}/clipmenu";
      CM_MAX_CLIPS="200";
      CM_SELECTIONS="clipboard primary";
      CM_IGNORE_WINDOW="dmenu";

      # Dotfile directory
      MY_DOTFILES_DIR="$HOME/voidrice";

      # VimWiki
      VIMWIKI_DIR="$HOME/Dropbox/vimWiki";
      VIMWIKI_DIR_PERSONAL="$VIMWIKI_DIR/Personal/wiki/";
      VIMWIKI_DIR_WORK="$VIMWIKI_DIR/Work/wiki/";
      VIMWIKI_DIR_INTERVIEWS="$VIMWIKI_DIR/InterviewsTaken/wiki/";
      VIMWIKI_DIR_DISCUSSIONS="$VIMWIKI_DIR/Discussions/wiki/";
      VIMWIKI_DIR_ACTIVE_TASKS="$VIMWIKI_DIR/ActiveTasks/wiki/";

      MOST_USED_VIMWIKI_DIR="$VIMWIKI_DIR_WORK";

      # Neorg
      NEORG_DIR="$HOME/Dropbox/Neorg";
      NEORG_DIR_PERSONAL="$NEORG_DIR/Personal";
      NEORG_DIR_WORK="$NEORG_DIR/Work";
      NEORG_DIR_INTERVIEWS="$NEORG_DIR/InterviewsTaken";
      NEORG_DIR_DISCUSSIONS="$NEORG_DIR/Discussions";
      NEORG_DIR_ACTIVE_TASKS="$NEORG_DIR/ActiveTasks";

      MOST_USED_NEORG_DIR="$NEORG_DIR_WORK";

      # Tmux default session file
      TMUX_DEFAULT_SESSION_FILE="$HOME/.config/tmux/private/default-session.json";

      # Taskwarrior
      TASKRC="$HOME/.config/taskwarrior/task/taskrc";
      TASKDATA="$HOME/Dropbox/taskwarrior";
      BUGWARRIORRC="$HOME/.config/taskwarrior/bugwarrior/bugwarriorrc";
      TIMEWARRIORDB="$HOME/Dropbox/timewarrior";

      # Dadbod dbui queries
      DB_QUERIES_PATH="$HOME/Dropbox/DBQueries";
      DADBOD_DB_QUERIES_PATH="$DB_QUERIES_PATH/db_ui_queries";

      # Rest-nvim http files
      REST_NVIM_COLLECTION_PATH="$HOME/Dropbox/rest_nvim_collection/collections";


      # Other program settings:
      DICS="/usr/share/stardict/dic/";
      # export SUDO_ASKPASS="$HOME/.local/bin/dmenupass";
      FZF_DEFAULT_OPTS="--layout=reverse --height 40%  --inline-info";
      FZF_DEFAULT_COMMAND="fd --hidden --follow --type f";
      BC_ENV_ARGS="$HOME/.config/bc/bcrc";

      # export LESS=-R
      LESS="-XFR";
      LESS_TERMCAP_mb="$(printf '%b' '[1;31m')";
      LESS_TERMCAP_md="$(printf '%b' '[1;36m')";
      LESS_TERMCAP_me="$(printf '%b' '[0m')";
      LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')";
      LESS_TERMCAP_se="$(printf '%b' '[0m')";
      LESS_TERMCAP_us="$(printf '%b' '[1;32m')";
      LESS_TERMCAP_ue="$(printf '%b' '[0m')";
      QT_QPA_PLATFORMTHEME="gtk2";	# Have QT use gtk2 theme.
      MOZ_USE_XINPUT2="1";		# Mozilla smooth scrolling/touchpads.
      AWT_TOOLKIT="MToolkit wmname LG3D";	#May have to install wmname
      _JAVA_AWT_WM_NONREPARENTING="1";	# Fix for Java applications in dwm


      # AUTOSSH variables
      AUTOSSH_DEBUG="7";
      AUTOSSH_LOGLEVEL="7";
      AUTOSSH_POLL="120";
      AUTOSSH_LOGFILE="$HOME/.cache/autossh.log";
      AUTOSSH_GATETIME="0";

      SSH_LOGFILE="$HOME/.cache/ssh.log";
      SSH_TUNNEL_CONFIG="$HOME/.ssh/tunnel-config";

      # VALE variables
      VALE_CONFIG_PATH="$HOME/.config/vale/vale.ini";

      # Specifying the local binary path to avoid conflict with `shortctus` utility available on macos
      # [ ! -f ${XDG_CONFIG_HOME}/shell/shortcutrc ] && $HOME/.local/bin/shortcuts >/dev/null 2>&1 &

      PATH = [
        "$ASDF_DATA_DIR/bin"
        "$ASDF_DATA_DIR/shims"
        "$GOBIN"
        "$PATH"
        # Adds `~/.local/bin` to $PATH
        ''$(du "${XDG_BIN_HOME}" | cut -f2 | paste -sd ':' -)''
        # Adds `NPM_CONFIG_PREFIX` to $PATH
        "${XDG_DATA_HOME}/npm/bin"
        # Adds android command line tools binaries to path
        "$ANDROID_HOME/emulator"
        "$ANDROID_HOME/cmdline-tools/latest/bin"
        "$ANDROID_HOME/platform-tools"
      ];
    };

    systemPackages = with pkgs; [           # System-Wide Packages
      neovim
      kitty
      curl
      wget              # Retriever
      coreutils         # GNU Utilities
      git               # Version Control
      killall           # Process Killer
      lf                # LF file manager
      tealdeer          # Helper
      jq                # JSON Processor
      fzf               # Fuzzy finder
      fd                # Find fast
      sd                # Find and replace sed alternative
      eza               # modern replacement of ls
      zoxide
      ripgrep
      tmux
      bottom
      delta
      lazygit
      lazydocker
      asdf-vm
      bat
      clipboard-jh      # Cross-platform clipboard manager

      usbutils          # Manage USB
      lshw              # Hardware Config
      nix-tree          # Browse Nix Store
      pciutils          # Manage PCI
      xdg-utils         # Environment integration

      # Video/Audio
      linux-firmware    # Proprietary Hardware Blob
      alsa-utils        # Audio Control
      mpv               # Media Player
      pavucontrol       # Audio Control
      pipewire          # Audio Server/Control
      pulseaudio        # Audio Server/Control
      qpwgraph          # Pipewire Graph Manager
      vlc               # Media Player

      # Apps
      appimage-run      # Runs AppImages on NixOS
      firefox           # Browser
      brave             # Browser
      google-chrome     # Browser
      telegram-desktop  # Telegram client

      # File Management
      p7zip             # Zip Encryption
      rsync             # Syncer - $ rsync -r dir1/ dir2/
      unzip             # Zip Files
      unrar             # Rar Files
      zip               # Zip
      zathura           # PDF viewer

      # Other Packages Found @
      # - ./<host>/default.nix
      # - ../modules
      # tree-sitter
      # wezterm
      # alacritty
      # vscode
      # kate
      # thunderbird
    ] ++
    (with unstable; [
      # Apps
      # firefox           # Browser
    ]);
  };

  programs = {
    dconf.enable = true;
  };

  hardware.pulseaudio.enable = true;
  services = {
    # printing = {                            # CUPS
    #   enable = false;
    # };
    # pipewire = {                            # Sound
    #   enable = true;
    #   alsa = {
    #     enable = true;
    #     support32Bit = true;
    #   };
    #   pulse.enable = true;
    #   jack.enable = true;
    # };
    openssh = {                             # SSH
      enable = true;
      allowSFTP = true;                     # SFTP
      extraConfig = ''
        HostKeyAlgorithms +ssh-rsa
      '';
    };
  };

  flatpak.enable = true;                    # Enable Flatpak (see module options)

  nix = {                                   # Nix Package Manager Settings
    settings ={
      auto-optimise-store = true;
    };
    gc = {                                  # Garbage Collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;    # Enable Flakes
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;        # Allow Proprietary Software.

  system = {                                # NixOS Settings
    #autoUpgrade = {                        # Allow Auto Update (not useful in flakes)
    #  enable = true;
    #  channel = "https://nixos.org/channels/nixos-unstable";
    #};
    stateVersion = "22.05";
  };

  home-manager.users.${vars.user} = {       # Home-Manager Settings
    home = {
      stateVersion = "22.05";
    };
    programs = {
      home-manager.enable = true;
    };
    xdg = {
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "image/jpeg" = ["image-roll.desktop" "feh.desktop"];
          "image/png" = ["image-roll.desktop" "feh.desktop"];
          "text/plain" = "nvim.desktop";
          "text/html" = "nvim.desktop";
          "text/csv" = "nvim.desktop";
          "application/pdf" = ["firefox.desktop" "google-chrome.desktop" "okularApplication_pdf.desktop"];
          "application/zip" = "org.gnome.FileRoller.desktop";
          "application/x-tar" = "org.gnome.FileRoller.desktop";
          "application/x-bzip2" = "org.gnome.FileRoller.desktop";
          "application/x-gzip" = "org.gnome.FileRoller.desktop";
          # "application/x-bittorrent" = "";
          "x-scheme-handler/http" = ["firefox.desktop" "google-chrome.desktop"];
          "x-scheme-handler/https" = ["firefox.desktop" "google-chrome.desktop"];
          "x-scheme-handler/about" = ["firefox.desktop" "google-chrome.desktop"];
          "x-scheme-handler/unknown" = ["firefox.desktop" "google-chrome.desktop"];
          "x-scheme-handler/mailto" = ["gmail.desktop"];
          "audio/mp3" = "mpv.desktop";
          "audio/x-matroska" = "mpv.desktop";
          "video/webm" = "mpv.desktop";
          "video/mp4" = "mpv.desktop";
          "video/x-matroska" = "mpv.desktop";
          "inode/directory" = "pcmanfm.desktop";
        };
      };
      desktopEntries.image-roll = {
        name = "image-roll";
        exec = "${pkgs.image-roll}/bin/image-roll %F";
        mimeType = ["image/*"];
      };
      desktopEntries.gmail = {
        name = "Gmail";
        exec = ''xdg-open "https://mail.google.com/mail/?view=cm&fs=1&to=%u"'';
        mimeType = ["x-scheme-handler/mailto"];
      };
    };
  };
}
