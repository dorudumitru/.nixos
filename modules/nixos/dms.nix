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
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    plugins = {
      dockerManager.enable = true;
    };
  };
}
