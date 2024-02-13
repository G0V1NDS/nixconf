#
#  Terminal Emulator
#

{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} =
  let
    config_dir = "alacritty";
  in
  {
    home.file.".config/${config_dir}" = {
      source = ./${config_dir};
      recursive = true;
      force = true;
    };
    # programs = {
    #   alacritty = {
    #   };
    # };
  };
}
