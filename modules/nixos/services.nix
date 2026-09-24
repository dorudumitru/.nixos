{ pkgs, ... }:

{
  services = {
    udisks2.enable = true;
    udev.packages = [ pkgs.bazecor ];
    gvfs.enable = true;
    tumbler.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [ thunar-archive-plugin ];
  };
}
