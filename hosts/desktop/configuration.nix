{
  imports = [
    ./hardware-configuration.nix

    ../../modules/nixos/boot.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/packages.nix
    ../../modules/nixos/hyprland.nix
    ../../modules/nixos/dms.nix
    ../../modules/nixos/docker.nix
  ];

  services = {
    displayManager.dms-greeter = {
      enable = true;
      compositor = {
        name = "hyprland";
        customConfig = ''
          hl.env("DMS_RUN_GREETER", "1")
          hl.config({ misc = { disable_hyprland_logo = true } })
          hl.monitor({
            output   = "",
            mode     = "3840x2160@59.940",
            position = "0x0",
            scale    = 1.5,
          })
        '';
      };
      configHome = "/home/dorudumitru";
      configFiles = [
        "/home/dorudumitru/.config/DankMaterialShell/settings.json"
      ];
      logs = {
        save = true;
        path = "/tmp/dms-greeter.log";
      };
    };
  };

  system.stateVersion = "26.05";
}
