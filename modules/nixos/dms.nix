{ inputs, ... }:

{
  imports = [
    inputs.dms-plugin-registry.nixosModules.default
  ];

  programs.dms-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };
    plugins = {
      dockerManager.enable = true;
    };
  };
}
