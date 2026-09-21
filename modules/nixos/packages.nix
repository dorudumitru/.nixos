{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    tree
    wget
    curl
    git
    adw-gtk3
    catppuccin-papirus-folders
    bibata-cursors
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    jetbrains-mono
    inter
    lilex
  ];

  programs.nix-ld.enable = true;
}
