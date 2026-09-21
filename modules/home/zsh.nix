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

        ''
          # functions
          function idea { ( intellij "$@" & ) > /dev/null 2>&1 }

          function tmux-ssh() {
            ssh "$1" -t -- /bin/sh -c 'tmux has-session && exec tmux attach || exec tmux'
          }

          function git-ssh() {
            if [[ "$1" == "work" ]]; then
              git config core.sshCommand 'ssh -o IdentitiesOnly=yes -o IdentityFile=$HOME/.ssh/work.pub'
              echo "Successfully configured \"Work\" ssh key for current repository"
            elif [[ "$1" == "personal" ]]; then
              git config core.sshCommand 'ssh -o IdentitiesOnly=yes -o IdentityFile=$HOME/.ssh/personal.pub'
              echo "Successfully configured \"Personal\" ssh key for current repository"
            else
              echo "Argument required: work | personal"
            fi
          }

          function kill-port() {
            if [[ -z "$1" ]]; then
              echo "Usage: kill-port <port>"
              return 1
            fi

            if ! lsof -i :"$1" -t > /dev/null; then
              echo "No process found running on port $1"
              return 0
            fi

            lsof -i :"$1" -t | xargs kill -9
          }

          # open tmux sessionizer with <C-f>
          bindkey -s "^f" "ts\n"

          # remove annoying error when using ssh with kitty
          [ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
        ''
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
      syntaxHighlighting.enable = true;

      shellAliases = {
        ls = "eza --icons=auto --group-directories-first";
        cat = "bat";
        vim = "nvim";
        ts = "tmux-sessionizer";
        ngp = "new-go-project";
        uao = "unzip-and-open";
        tssh = "tmux-ssh";
        lg = "lazygit";
        fp = ". find-project";
        yz = "yazi";
        oc = "opencode";
        cc = "claude";
        cx = "codex";
        visualvm = "visualvm --fontsize 20";
        zb = "zmk-battery";
      };
    };

    starship.enable = true;

    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };

    fzf = {
      enable = true;
      defaultOptions = [
        "--prompt=❯ "
        "--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796"
        "--color=fg:#cad3f5,header:#ed8796,info:#8bd5ca,pointer:#ed8796"
        "--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"
        "--color=selected-bg:#494d64"
        "--color=border:#8aadf4,label:#cad3f5"
      ];
    };
  };
}
