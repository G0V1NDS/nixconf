#
#  Shell
#

{ pkgs, vars, ... }:

{
  users.users.${vars.user} = {
    shell = pkgs.zsh;
  };

  home-manager.users.${vars.user} =
  let
    config_dir_shell = "shell";
    config_dir_zsh= "zsh";
  in
  {
    home.file.".config/${config_dir_shell}" = {
      source = ./${config_dir_shell};
      recursive = true;
      force = true;
    };
    home.file.".config/${config_dir_zsh}" = {
      source = ./${config_dir_zsh};
      recursive = true;
      force = true;
    };
  };

  # programs = {
  #   zsh = {
  #     enable = true;
  #     autosuggestions.enable = true;
  #     syntaxHighlighting.enable = true;
  #     enableCompletion = true;
  #     histSize = 100000;
  #
  #     ohMyZsh = {                               # Plug-ins
  #       enable = true;
  #       plugins = [ "git" ];
  #     };
  #
  #     shellInit = ''
  #       # Spaceship
  #       source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
  #       autoload -U promptinit; promptinit
  #       # Hook direnv
  #       #emulate zsh -c "$(direnv hook zsh)"
  #
  #       #eval "$(direnv hook zsh)"
  #     '';                                       # Theming
  #   };
  # };
}
