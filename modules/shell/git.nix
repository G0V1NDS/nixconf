#
#  Git
#

{ pkgs, vars, ... }:
{
  home-manager.users.${vars.user} = {
    home.file.".config/git" = {
      source = ./git;
      recursive = true;
    };
  };
  programs = {
    git = {
      enable = true;
    };
  };
}
