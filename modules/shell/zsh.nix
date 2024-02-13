#
#  Shell
#

{ pkgs, vars, ... }:

{
  users.users.${vars.user} = {
    shell = pkgs.zsh;
  };

  home-manager.users.${vars.user} = {
    home.file.".config/shell" = {
      source = ./shell;
      recursive = true;
    };
    home.file.".config/zsh" = {
      source = ./zsh;
      recursive = true;
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
