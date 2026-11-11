{
  inputs,
  pkgs,
  ...
}:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    inputs.oniri.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };
}
