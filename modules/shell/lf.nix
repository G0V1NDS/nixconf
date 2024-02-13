#
#  Lf file manager
#

{ pkgs, vars, ... }:
{
  environment.systemPackages = with pkgs; [
    # For lf preview
    ffmpeg
    ffmpegthumbnailer
    imagemagick
    ghostscript
    poppler
    # wkhtmltopdf
  ];
  home-manager.users.${vars.user} =
  let
    config_dir = "lf";
  in
  {
    home.file.".config/${config_dir}" = {
      source = ./${config_dir};
      recursive = true;
    };

    programs = {
      lf = {
        enable = true;
      };
    };
  };
}
