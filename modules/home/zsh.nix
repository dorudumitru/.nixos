{
  config,
  lib,
  ...
}:

{
  home = {
    sessionVariables = {
      EDITOR = "nvim";
      GIT_EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
      GOPATH = "${config.home.homeDirectory}/.go";
    };

    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
      "${config.home.homeDirectory}/.go/bin"
    ];
  };

  programs = {
    zsh = {
      enable = true;

      initContent = lib.mkMerge [
        # must be set before oh-my-zsh is sourced
        (lib.mkBefore "ZSH_DISABLE_COMPFIX=true")

        # mkAfter = sourced at the very end, so local tweaks can override
        # everything above (plugins, aliases, highlighting).
        (lib.mkAfter ''
          [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
        '')
      ];

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "vi-mode"
        ];
      };

      enableCompletion = true;
      autosuggestion.enable = true;
      fastSyntaxHighlighting = {
        enable = true;
        theme = "XDG:catppuccin-macchiato";
      };
    };

    starship.enable = true;

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };

    fzf = {
      enable = true;
    };
  };
}
