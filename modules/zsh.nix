{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;

    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableBashCompletion = true;
    enableCompletion = true;

    histSize = 10000;

    shellAliases = {
      ls = "lsd";
      sl = "lsd";
      l = "lsd -l";
      ll = "lsd -l";
      la = "lsd -lA";
      lt = "lsd -l --tree --depth 3";
      tree = "lsd --tree";
    };

    promptInit = ''
      PROMPT='[%D{%H:%M:%S}] %B%F{yellow}%n%f%b%B%F{white}@%f%b%B%F{magenta}%m%f%b %B%F{green}%~%f%b
      %B%F{green}@%f%b '
    '';

    interactiveShellInit = ''
      # activate vi mode
      bindkey -v

      # escape delay to 10ms
      export KEYTIMEOUT=1

      # vi mode fixes
      bindkey -M viins '^?' backward-delete-char
      bindkey -M viins '^H' backward-delete-char

      # fzf
      eval "$(fzf --zsh)"
    '';
  };

  environment.sessionVariables = {
    FZF_DEFAULT_OPTS = "--layout reverse";
  };

  environment.systemPackages = with pkgs; [
    fzf
    lsd
  ];
}
