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
      dankBatteryAlerts.enable = true;
      dockerManager.enable = true;
    };
  };
}
