{ pkgs, ... }:

{
  home.packages = with pkgs; [
    _7zip-zstd
    bat
    bitwarden-desktop
    brave
    btop
    claude-code
    codex
    delta
    docker
    dysk
    eza
    fd
    gcc
    ghostty
    github-cli
    gnome-calculator
    gnome-characters
    gnumake
    jetbrains-toolbox
    kitty
    lazydocker
    lazygit
    lsof
    luarocks
    neovim
    opencode
    pipx
    ripgrep
    rustup
    sqlit-tui
    stremio-linux-shell
    thunar
    thunar-archive-plugin
    tealdeer
    tmux
    tree-sitter
    tumbler
    unzip
    uv
    visualvm
    vscode
    wayscriber
    xarchiver
    xdg-utils
    xournalpp
    yazi
    yubioath-flutter
    zathura
    zip

    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    })

    (pkgs.writeShellApplication {
      name = "zmk-battery";
      runtimeInputs = [ (pkgs.python3.withPackages (ps: [ ps.bleak ])) ];
      text = ''exec python "$HOME/.local/bin/zmk-battery.py" "$@"'';
    })
  ];
}
