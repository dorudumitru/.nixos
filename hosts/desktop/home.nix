{
  imports = [
    ../../modules/home/dotfiles.nix
    ../../modules/home/packages.nix
    ../../modules/home/gtk.nix
    ../../modules/home/zsh.nix
    ../../modules/home/localsend.nix
    ../../modules/home/dev.nix
  ];

  home = {
    username = "dorudumitru";
    homeDirectory = "/home/dorudumitru";
    stateVersion = "26.05";
  };
}
