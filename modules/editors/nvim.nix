#
#  Neovim
#

{ config, lib, pkgs, vars, ...}:

{
  config = {
    environment.systemPackages = with pkgs; [
      python3
      nodejs
      go
    ];

    home-manager.users.${vars.user} = {
      home.file.".config/nvim" = {
        source = ./nvim;
        recursive = true;
      };
    };
  };
}
