{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
  };
  services = { nix-daemon = { enable = true; }; };
  nix.package = pkgs.nix;
  nix.settings.trusted-users = [ "root" "riordan" ];
  networking.hostName = "rmbp";
  networking.computerName = "rmbp";
  users.users.riordan = {
    name = "riordan";
    home = "/Users/riordan";
  };

  homebrew = {
    enable = true;
    global.brewfile = true;
    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };
    # disabling quarantine would mean no stupid macOS do-you-really-want-to-open dialogs
    caskArgs.no_quarantine = true;
    taps = [
      "homebrew/cask-fonts"
      "homebrew/services"
      "homebrew/cask-versions"
      # "stripe/cli"
    ];

    masApps = {
      Xcode = 497799835;
      Slack = 803453959;
      Bitwarden = 1352778147;
    };

    casks = [
      "discord"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "google-chrome"
      "hammerspoon"
      "slack"
      "zoom"
      "visual-studio-code"
      "arc"
      "linear-linear"
      "orbstack"
      "rectangle"
      "soundsource"
      "istat-menus"
      "raycast"
      "iina"
      "tableplus"
      "microsoft-teams"
    ];
  };

  system = {
    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        orientation = "bottom";
        tilesize = 42;
        showhidden = true;
        show-recents = true;
        show-process-indicators = true;
        expose-animation-duration = 0.1;
        expose-group-by-app = true;
        launchanim = false;
        mineffect = "scale";
        mru-spaces = false;
        # customize Hot Corners
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
      };
      NSGlobalDomain = {
        ApplePressAndHoldEnabled = false;
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        AppleShowScrollBars = "Always";
        NSWindowResizeTime = 0.1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        AppleInterfaceStyle = "Dark";
        NSDocumentSaveNewDocumentsToCloud = false;
        _HIHideMenuBar = false;
        "com.apple.springing.delay" = 0.0;
      };
      finder = {
        FXPreferredViewStyle = "Nlsv";
        _FXShowPosixPathInTitle = true;
        FXEnableExtensionChangeWarning = false;
        AppleShowAllFiles = true;
        ShowStatusBar = true;
        ShowPathbar = true;
      };
      CustomUserPreferences = { 
        ".GlobalPreferences" = {
          # automatically switch to a new space when switching to the application
          AppleSpacesSwitchOnActivate = false;
        };
        "com.apple.NetworkBrowser" = { "BrowseAllInterfaces" = true; };
        # "WebAutomaticTextReplacementEnabled" = true;
        # "com.apple.screensaver" = {
        #   "askForPassword" = true;
        #   "askForPasswordDelay" = 0;
        # };
        # "com.apple.trackpad" = { "scaling" = 2; };
        # "com.apple.mouse" = { "scaling" = 2.5; };
        "com.apple.LaunchServices" = { "LSQuarantine" = true; };
        "com.apple.finder" = {
          "ShowExternalHardDrivesOnDesktop" = false;
          "ShowRemovableMediaOnDesktop" = false;
          "WarnOnEmptyTrash" = false;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };

        "com.apple.spaces" = {
          "spans-displays" = 0; # Display have seperate spaces
        };  
        "com.apple.screencapture" = {
          location = "~/Pictures/screenshots";
          type = "png";
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.spaces" = {
          "spans-displays" = 0; # Display have seperate spaces
        };
        "NSGlobalDomain" = {
          "NSNavPanelExpandedStateForSaveMode" = true;
          "NSTableViewDefaultSizeMode" = 1;
          "WebKitDeveloperExtras" = true;
        };
        "com.apple.ImageCapture" = { "disableHotPlug" = true; };
        # "com.apple.Safari" = {
        #   "IncludeInternalDebugMenu" = true;
        #   "IncludeDevelopMenu" = true;
        #   "WebKitDeveloperExtrasEnabledPreferenceKey" = true;
        #   "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" =
        #     true;
        # };
      };
    };
  };

  security.pam.enableSudoTouchIdAuth = true;
}
