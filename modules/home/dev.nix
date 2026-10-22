{
  programs = {
    mise = {
      enable = true;
      enableZshIntegration = true;
      mutableSettings = true;
      globalConfig = {
        settings.all_compile = false;
        tools = {
          node = "lts";
          python = "3";
          go = "1";
          java = "temurin-25";
        };
      };
    };
    direnv = {
      enable = true;
      mise.enable = true;
    };
  };
}
