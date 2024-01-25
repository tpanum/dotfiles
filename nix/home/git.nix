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
      init = {
        defaultBranch = "main";
      };
      push = {
        followTags = true;
        autoSetupRemote = true;
      };
      pull = { rebase = true; };
      rebase = { autoStash = true; };
      hub = { protocol = "ssh"; };
      credential.helper = "${pkgs.pass-git-helper}/bin/pass-git-helper";
    };
  };

  xdg = {
    configFile."pass-git-helper/git-pass-mapping.ini".text = ''
      [DEFAULT]
      skip_password=6
      regex_username=^user: (.*)$
      username_extractor=regex_search
      regex_password=^pass: (.*)$

      [git.overleaf.com]
      target=overleaf/account
      '';
  };
}
