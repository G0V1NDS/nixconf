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

    home-manager.users.${vars.user} =
    let
      config_dir = "nvim";
    in
    {
      home.file.".config/${config_dir}" = {
        source = ./${config_dir};
        recursive = true;
      };
    };
  };
}
