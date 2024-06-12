{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    git-lfs
  ];
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f ~/.gitconfig
  '';
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        features = "side-by-side line-numbers decorations";
      };
    };
    userName = "Riordan Pawley";
    userEmail = "riordan@dogg.com.au";
    aliases = {
      co = "checkout";
      count = "shortlog -sn";
      g = "grep --break --heading --line-number";
      gi = "grep --break --heading --line-number -i";
      changed = ''show --pretty="format:" --name-only'';
      fm = "fetch-merge";
      please = "push --force-with-lease";
      commit = "commit -s";
      commend = "commit -s --amend --no-edit";
      lt = "log --tags --decorate --simplify-by-decoration --oneline";
      unshallow = "fetch --prune --tags --unshallow";
    };
    extraConfig = {
      lfs = { enable = true; };
      core = {
        editor = "nvim";
        compression = -1;
        autocrlf = "input";
        whitespace = "trailing-space,space-before-tab";
        precomposeunicode = true;
      };
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        ui = true;
      };
      advice = { addEmptyPathspec = false; };
      apply = { whitespace = "nowarn"; };
      help = { autocorrect = 1; };
      grep = {
        extendRegexp = true;
        lineNumber = true;
      };
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
      merge.conflictStyle = "diff3";
      submodule = { fetchJobs = 4; };
      log = { showSignature = false; };
      format = { signOff = true; };
      rerere = { enabled = true; };
      pull = { ff = "only"; rebase = false; };
      init = { defaultBranch = "main"; };
    };
    ignores = lib.splitString "\n" (builtins.readFile ./gitignore_global);
  };
}
