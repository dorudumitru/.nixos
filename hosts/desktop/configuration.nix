{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.dms-plugin-registry.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Bucharest";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

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

  nixpkgs.config.allowUnfree = true;

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    dms-shell = {
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
    firefox.enable = true;
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "vi-mode"
          "direnv"
        ];
      };
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        vim = "nvim";
      };
    };
    nix-ld.enable = true;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    tree
    wget
    curl
    git
    ghostty
    kitty
    gnome-characters
    adw-gtk3
    catppuccin-papirus-folders
    bibata-cursors
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    jetbrains-mono
    inter
    lilex
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

  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [
    #   22
    # ];
  };

  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  system.stateVersion = "26.05";
}
