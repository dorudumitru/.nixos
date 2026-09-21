{ pkgs, ... }:

{
  users = {
    users.dorudumitru = {
      isNormalUser = true;
      description = "Doru Dumitru";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
    defaultUserShell = pkgs.zsh;
  };

  # System-level base only; the user's zsh config lives in modules/home/zsh.nix
  programs.zsh.enable = true;
}
