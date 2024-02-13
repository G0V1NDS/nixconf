#
#  Terminal Emulator
#

{ pkgs, vars, ... }:

let
  colors = import ../theming/colors.nix;
in
{
  home-manager.users.${vars.user} =
  let
    config_dir = "kitty";
  in
  {
    home.file.".config/${config_dir}" = {
      source = ./${config_dir};
      recursive = true;
      force = true;
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
