{ pkgs, ... }:

{
  home.packages = with pkgs; [
    _7zip-zstd
    bat
    bazecor # needs to be started with --ozone-platform=wayland to fix pixelated/blurred font
    bitwarden-desktop
    brave
    btop
    claude-code
    cliamp
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
    jetbrains.idea
    kitty
    lazydocker
    lazygit
    localsend
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
    whatsapp-electron
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
      runtimeInputs = [ (pkgs.python3.withPackages (ps: [ ps.dbus-next ])) ];
      text = ''exec python "$HOME/.local/bin/zmk-battery.py" "$@"'';
    })
  ];
}
