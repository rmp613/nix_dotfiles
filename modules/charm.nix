{ pkgs, ... }: {
  home.packages = with pkgs; [
    glow
    gum
    tz
  ];
}
