#
#  Tmux
#

{ pkgs, vars, ... }:
{
  home-manager.users.${vars.user} =
  let
    config_dir = "tmux";
  in
  {
    home.file.".config/${config_dir}" = {
      source = ./${config_dir};
      recursive = true;
      force = true;
    };
  };
  programs = {
    tmux = {
      enable = true;
    };
  };
}
