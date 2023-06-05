{ config, pkgs, ... }: {
  targets.darwin.defaults = {
    "com.apple.Safari.SandboxBroker".ShowDevelop = true;
    "com.apple.Safari".AutoFillPasswords = false;
    "com.apple.Safari".IncludeDevelopMenu = true;
    "com.apple.Safari".ShowOverlayStatusBar = true;
    "com.apple.Safari".AutoOpenSafeDownloads = false;
    "com.apple.Safari".AutoFillCreditCardData = false;
  };

  launchd.agents = {
    pbcopy = {
      enable = true;
      config = {
        Label = "localhost.pbcopy";
        ProgramArguments = [ "/usr/bin/pbcopy" ];
        RunAtLoad = true;
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        ProcessType = "Background";
        EnvironmentVariables = { "LC_CTYPE" = "UTF-8"; };
        inetdCompatibility = { Wait = false; };
        Sockets = {
          Listener = {
            SockServiceName = "2224";
            SockNodeName = "127.0.0.1";
          };
        };
      };
    };
    pbpaste = {
      enable = true;
      config = {
        Label = "localhost.pbpaste";
        ProgramArguments = [ "/usr/bin/pbpaste" ];
        RunAtLoad = true;
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        ProcessType = "Background";
        inetdCompatibility = { Wait = false; };
        EnvironmentVariables = { "LC_CTYPE" = "UTF-8"; };
        Sockets = {
          Listener = {
            SockServiceName = "2225";
            SockNodeName = "127.0.0.1";
          };
        };
      };
    };
    xdg-open = {
      enable = true;
      config = {
        Label = "localhost.xdg-open";
        ProgramArguments =
          [ "${pkgs.nur.repos.caarlos0.xdg-open-svc}/bin/xdg-open-svc" ];
        KeepAlive = true;
        RunAtLoad = true;
        StandardErrorPath = "${config.xdg.cacheHome}/xdg-open-svc.log";
        StandardOutPath = "${config.xdg.cacheHome}/xdg-open-svc.log";
      };
    };
  };

  programs.fish.shellInit = ''
      if test -e "/Applications/Postgres.app"
    	fish_add_path -a /Applications/Postgres.app/Contents/Versions/latest/bin/
      end

      if test -e "/Applications/WezTerm.app"
    	fish_add_path -a /Applications/Wezterm.app/Contents/MacOS/
      end

      fish_add_path -a /opt/homebrew/bin/
  '';
}
