# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, ... }:
{
  imports =
    [
      ../shared.nix
      ./hardware.nix
    ];

  networking.hostName = "darkstar";

  # https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  virtualisation.docker = {
    enable = true;
    daemon = {
      settings = {
        dns = [ "1.1.1.1" ];
      };
    };
    autoPrune = {
      enable = true;
    };
  };
  users.users.riordan.extraGroups = [ "docker" ];

  services.qemuGuest.enable = true;
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "riordan" ];
    ensureUsers = [
      {
        name = "riordan";
        ensureClauses = {
          login = true;
          createrole = true;
          createdb = true;
          superuser = true;
        };
      }
    ];
    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE  DATABASE        USER            ADDRESS                 METHOD
      local   all             all                                     trust
      host    all             all             127.0.0.1/32            trust
      host    all             all             ::1/128                 trust
    '';
  };

  environment.systemPackages = with pkgs; [
    coreutils-full
    dig
    gcc
    inetutils
    util-linux
  ];

  networking.firewall.allowedTCPPortRanges = [
    { from = 1024; to = 65535; } # high ports
  ];

  systemd.timers."backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };
  };

  # NOTE: need to run `rclone config` once for it to work.
  systemd.services."backup" = {
    path = with pkgs; [
      rclone
      curl
      openssh
    ];
    script = ''
      rclone sync -v \
        --no-update-modtime \
        --disable PartialUploads \
        --links \
        --exclude 'Go/' \
        --exclude 'forks/' \
        --exclude '**/.direnv/' \
        --exclude '**/dist/' \
        --exclude '**/.git/' \
        $HOME/prog/ nas:/darkstar/
      rclone copy $HOME/.localrc.fish nas:/darkstar/
      rclone copy $HOME/.local/share/fish/fish_history nas:/darkstar/
      curl -sf https://hc-ping.com/$(cat $HOME/prog/.PING_ID)
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "riordan";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

