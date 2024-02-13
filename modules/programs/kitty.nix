#
#  Terminal Emulator
#

{ pkgs, vars, ... }:

let
  colors = import ../theming/colors.nix;
in
{
  home-manager.users.${vars.user} = {
    home.file.".config/kitty" = {
      source = ./kitty;
      recursive = true;
    };
    # programs = {
    #   kitty = {
    #     enable = true;
    #     theme = "Afterglow";
    #     settings = {
    #       confirm_os_window_close=0;
    #       enable_audio_bell="no";
    #       resize_debounce_time="0";
    #       background="#${colors.scheme.default.hex.bg}";
    #     };
    #   };
    # };
  };
}
