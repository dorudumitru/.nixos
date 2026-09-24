{ pkgs, ... }:

{
  services = {
    udisks2.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    udev.packages = [ pkgs.bazecor ];
  };
}
