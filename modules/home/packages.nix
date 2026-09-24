{ pkgs, ... }:

{
  home.packages = with pkgs; [
    _7zip-zstd
    bat
    bazecor # needs to be started with --ozone-platform=wayland to fix pixelated/blurred font
    bitwarden-desktop # needs to be started with --ozone-platform=wayland to fix pixelated/blurred font
    brave # needs to be started with --ozone-platform=wayland to fix pixelated/blurred font
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
    icu
    jetbrains.idea
    jq
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
    tealdeer
    tmux
    tree-sitter
    unzip
    uv
    visualvm
    vscode
    wayscriber
    whatsapp-electron # needs to be started with --ozone-platform=wayland to fix pixelated/blurred font
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
