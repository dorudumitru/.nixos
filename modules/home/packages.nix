{
  pkgs,
  inputs,
  ...
}:

let
  # Get the latest URL: curl -s 'https://data.services.jetbrains.com/products/releases?code=IIU&latest=true' | jq '.IIU[0].downloads.linux.link'
  # Get the hash: nix store prefetch-file --hash-type sha256 <url>
  # TODO: comment this override and the two `idea-2026_3` usages below
  # once nixpkgs unstable ships jetbrains.idea >= 2026.3
  idea-2026_3 = pkgs.jetbrains.idea.overrideAttrs (_: rec {
    version = "2026.3";
    src = pkgs.fetchurl {
      url = "https://download.jetbrains.com/idea/idea-${version}.tar.gz";
      hash = "sha256-alP/cfSgat1Ml+3E7+hsgxGf+C5bXp8dti/JWZW9ayU=";
    };
  });
in
{
  home.packages = with pkgs; [
    _7zip-zstd
    bat
    bazecor # needs to be started with --enable-features=UseOzonePlatform --ozone-platform=wayland to fix pixelated/blurred font
    bitwarden-desktop # needs to be started with --enable-features=UseOzonePlatform --ozone-platform=wayland to fix pixelated/blurred font
    btop
    claude-code
    cliamp
    # codex
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
    idea-2026_3
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

    # not in nixpkgs yet (PR nixpkgs#363992 still open)
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

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
      exec ${idea-2026_3}/intellij-idea/bin/idea "$@" >/dev/null 2>&1 </dev/null &
    '')
  ];
}
