{ lib, pkgs, config, ... }:
let
    private = {
      name       = "Thomas Kobber Panum";
      email      = "thomas@panum.dk";
      signingKey = "DCE0 69B9 4646 DF44 855E E61C 26D6 434F 7BFB 276E";
    };
in
{
  programs.git = {
    enable = true;
    userName = private.name;
    userEmail = private.email;
    ignores = [".gitignore"];
    signing = {
      key = private.signingKey;
      signByDefault = true;
    };
    lfs.enable = true;
    extraConfig = {
      core = {
        autocrlf = "true";
        whitespace = "cr-at-eol";
      };
      pull = { rebase = true; };
      rebase = { autoStash = true; };
      hub = { protocol = "ssh"; };
      # url = { "git@github.com:".insteadOf = "https://github.com/"; };
    };
  };
}
