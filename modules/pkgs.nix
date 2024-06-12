{ pkgs, lib, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };
  home.packages = with pkgs; with pkgs.nodePackages_latest; [
    # custom packages
    (pkgs.callPackage ../pkgs/bins { })
    # age # modern encryption tool
    comma # https://github.com/nix-community/comma runs without install via , prefixing tools
    # cosign # container signing
    curl
    entr # run commands when files change
    fd # find alt
    # gnumake
    # go-task
    graphviz
    httpstat
    hyperfine # cli benchmarking
    # inetutils 
    jq # json parser
    moreutils # random additional commands such as "parallel" to run commands in parallel
    # ncdu # disk usage analyzer warning - this will break until i figure out the zig header issues
  
    nodejs
    onefetch # git repo summary
    p7zip
    ranger # file manager
    broot # file manager
    ripgrep # grep alt
    scc # code counter
    sqlite # db
    tldr 
    # unixtools.watch
    # unrar
    vegeta # load testing
    wget # download

    # gke stuff
    # (google-cloud-sdk.withExtraComponents [
    #   google-cloud-sdk.components.gke-gcloud-auth-plugin
    # ])
    # kubectl
    # kubectx
    # stern
    # argocd

    # From NUR

    # treesitter, lsps, formatters, etc
    bash-language-server
    biome
    cargo
    clang-tools # clangd lsp
    delve
    dockerfile-language-server-nodejs
    gofumpt
    golangci-lint-langserver
    nil # nix lsp
    nixpkgs-fmt
    pgformatter
    prettier
    rust-analyzer
    rustc
    rustfmt
    shellcheck
    shfmt
    sql-formatter
    stylua
    sumneko-lua-language-server
    taplo # toml lsp
    terraform-ls
    tflint
    tree-sitter
    typescript-language-server
    vscode-html-languageserver-bin
    vscode-json-languageserver-bin
    yaml-language-server
    yamllint
    # broken till i figure out the zig header issues
    # zig
    # zls # zig lsp
  ] ++ (lib.optionals pkgs.stdenv.isDarwin [
    terminal-notifier
    coreutils
  ]) ++ (lib.optionals pkgs.stdenv.isLinux [
    docker
    docker-compose
    lm_sensors
    util-linux
    fswatch
    ffmpeg_6-full # failing on macos
    # https://nixos.wiki/wiki/podman
    # podman
    # shadow
  ]);
}
