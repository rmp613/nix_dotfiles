{ ... }: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = ''
      return {
        color_scheme = "Catppuccin Mocha",
        hide_tab_bar_if_only_one_tab = true
        default_prog = { '/Users/riordan/.nix-profile/bin/fish', '-l' }
        -- config.default_prog = { '/Users/riordan/.nix-profile/bin/fish', '-l' }
      }
    '';
  };
}