{ hostname, ... }:

{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        53317
      ];
      allowedUDPPorts = [
        53317
      ];
    };
  };
}
