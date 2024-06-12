{ pkgs, config, ... }: {
  programs.fish = {
    enable = true;
    shellInit = ''
      if test -f ~/.localrc.fish
          source ~/.localrc.fish
      end
    '';
    interactiveShellInit = ''
      # disable fish greeting
      set fish_greeting
      fish_config theme choose "Catppuccin Mocha"
    '';
    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair-fish.src;
      }
    ];
    shellAliases = {
      # docker
      d = "docker";
      dp = "podman";

      # git
      g = "git";
      gl = "git pull --prune";
      glg = "git log --graph --decorate --oneline --abbrev-commit";
      glga = "glg --all";
      gp = "git push origin HEAD";
      gpa = "git push origin --all";
      gd = "git diff";
      gc = "git commit -s";
      gca = "git commit -sa";
      gco = "git checkout";
      gb = "git branch -v";
      ga = "git add";
      gaa = "git add -A";
      gcm = "git commit -sm";
      gcam = "git commit -sam";
      gs = "git status -sb";
      glnext = "git log --oneline (git describe --tags --abbrev=0 @^)..@";
      gw = "git switch";
      gm = "git switch (git main-branch)";
      gms = "git switch (git main-branch); and git sync";
      egms = "e; git switch (git main-branch); and git sync";
      gwc = "git switch -c";

      # go
      gmt = "go mod tidy";
      grm = "go run ./...";

      # terraform
      tf = "terraform";

      # tmux
      ta = "tmux new -A -s default";

      # mods
      gcai =
        "git --no-pager diff | mods 'write a commit message for this patch. also write the long commit message. use semantic commits. break the lines at 80 chars' >.git/gcai; git commit -a -F .git/gcai -e";
    };
  };

  xdg.configFile."fish/functions" = {
    source = config.lib.file.mkOutOfStoreSymlink ./functions;
  };

  xdg.configFile."fish/themes/Catppuccin Mocha.theme" = {
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/fish/main/themes/Catppuccin%20Mocha.theme";
      sha256 = "sha256-MlI9Bg4z6uGWnuKQcZoSxPEsat9vfi5O1NkeYFaEb2I=";
    };
  };
}
