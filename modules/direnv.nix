{ pkgs, ... }:
let
  homeDirectory = (if pkgs.stdenv.isDarwin then "/Users/" else "/home/")
    + "riordan";
in
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = { load_dotenv = true; };
      whitelist = {
        prefix = [
          "${homeDirectory}/prog/" # todo: think about making this more secure
        ];
      };
    };
  };
}
