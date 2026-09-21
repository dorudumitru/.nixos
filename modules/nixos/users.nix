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

  programs.zsh.enable = true;
}
