{
  programs = {
    mise = {
      enable = true;
      enableMutableConfig = true;
      enableZshIntegration = true;
      globalConfig.settings.all_compile = false;
    };
    direnv = {
      enable = true;
      mise.enable = true;
    };
  };
}
