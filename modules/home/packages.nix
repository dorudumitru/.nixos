{ pkgs, ... }:

{
  home.packages = with pkgs; [
    _7zip-zstd
    bat
    bazecor # needs to be started with --enable-features=UseOzonePlatform --ozone-platform=wayland to fix pixelated/blurred font
    bitwarden-desktop # needs to be started with --enable-features=UseOzonePlatform --ozone-platform=wayland to fix pixelated/blurred font
    brave # needs to be started with --enable-features=UseOzonePlatform --ozone-platform=wayland to fix pixelated/blurred font
    btop
    claude-code
    cliamp
    codex
    codecrafters-cli
    delta
    docker
    dysk
    eza
    fastfetch
    fd
    gcc
    ghostty
    github-cli
    gnome-calculator
    gnome-characters
    gnumake
    jetbrains.idea
    jq
    k9s
    kitty
    kubectl
    kubernetes-helm
    lazydocker
    lazygit
    localsend
    lsof
    nautilus
    neovim
    opencode
    openssl
    pipx
    protobuf
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
    vscode # needs to be started with --enable-features=UseOzonePlatform --ozone-platform=wayland to fix pixelated/blurred font
    wayscriber
    whatsapp-electron # needs to be started with --enable-features=UseOzonePlatform --ozone-platform=wayland to fix pixelated/blurred font
    wl-clipboard
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

    (pkgs.writeShellScriptBin "idea" ''
      exec ${jetbrains.idea}/intellij-idea/bin/idea "$@" >/dev/null 2>&1 </dev/null &
    '')
  ];
}
