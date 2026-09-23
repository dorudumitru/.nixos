{
  programs = {
    mise = {
      enable = true;
      enableMutableConfig = true;
      enableZshIntegration = true;
      globalConfig = {
        settings.all_compile = false;
        tools = {
          node = "lts";
          python = "3.14";
          go = "1.27";
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
