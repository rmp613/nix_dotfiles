{ ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        color_scheme = "Catppuccin Mocha",
        hide_tab_bar_if_only_one_tab = true
        # config.default_prog = { '/usr/local/bin/fish', '-l' }
      }
    '';
  };
};