{
  config,
  lib,
  ...
}:
let
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  dotfiles = "${config.home.homeDirectory}/.dotfiles";

  # "location_where_symlink_will_be_created" = "path_in_dotfiles_folder"
  files = {
    "Documents/Go" = "gofiles/Documents/Go";

    ".gitconfig" = "home/.gitconfig";
    ".ideavimrc" = "home/.ideavimrc";

    ".config/bat" = "config/bat";
    ".config/btop" = "config/btop";
    ".config/delta" = "config/delta";
    ".config/eza" = "config/eza";
    ".config/kitty" = "config/kitty";
    ".config/lazydocker" = "config/lazydocker";
    ".config/lazygit" = "config/lazygit";
    ".config/nvim" = "config/nvim";
    ".config/starship.toml" = "config/starship.toml";
    ".config/tmux" = "config/tmux";
    ".config/Code/User/keybindings.json" = "config/Code/User/keybindings.json";
    ".config/Code/User/settings.json" = "config/Code/User/settings.json";
    ".config/yazi" = "config/yazi";
    ".config/zathura" = "config/zathura";

    ".local/bin/find-project" = "localbin/fp/find-project";
    ".local/bin/new-go-project" = "localbin/ngp/new-go-project";
    ".local/bin/tmux-sessionizer" = "localbin/ts/tmux-sessionizer";
    ".local/bin/unzip-and-open" = "localbin/uao/unzip-and-open";
    ".local/bin/zmk-battery.py" = "localbin/zb/zmk-battery.py";

    ".config/hypr/hyprland.lua" = "hypr/hyprland.lua";
    ".config/hypr/dms/binds.lua" = "hypr/dms/binds.lua";
    ".config/hypr/dms/colors.lua" = "hypr/dms/colors.lua";
    ".config/hypr/dms/cursor.lua" = "hypr/dms/cursor.lua";
    ".config/hypr/dms/layout.lua" = "hypr/dms/layout.lua";
    ".config/hypr/dms/outputs.lua" = "hypr/dms/outputs.lua";
    ".config/hypr/dms/windowrules.lua" = "hypr/dms/windowrules.lua";
  };

in
{
  home.activation.createDirectories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p \
      "$HOME/Books" \
      "$HOME/Documents" \
      "$HOME/Downloads" \
      "$HOME/Photos" \
      "$HOME/Projects/personal" \
      "$HOME/Projects/work"
  '';

  home.file = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) files;
}
