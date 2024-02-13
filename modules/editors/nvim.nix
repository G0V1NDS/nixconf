#
#  Neovim
#

{ config, lib, pkgs, vars, ...}:

{
  config = {
    environment.systemPackages = with pkgs; [
      xclip
      gcc
      python3
      nodejs
      go
      rustc
      cargo
      luajitPackages.luarocks
      nixd
    ];

    home-manager.users.${vars.user} = {
      home.file.".config/nvim" = {
        source = ./nvim;
        recursive = true;
      };
    };
  };
}
