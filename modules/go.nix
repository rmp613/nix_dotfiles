{ pkgs, ... }: {
  programs.go = {
    enable = true;
    package = pkgs.go_1_22;
    goPath = "prog/Go";
    goPrivate = [
      "github.com/caarlos0"
      "github.com/charmbracelet"
      "github.com/goreleaser"
    ];
  };
}
