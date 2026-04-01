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
    ignores = [".gitignore"];
    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519";
      signByDefault = true;
    };
    lfs.enable = true;
    settings = {
      user = {
        name = private.name;
        email = private.email;
      };
      gpg = {
        format = "ssh";
      };

      rerere = {
        enable = true;
      };

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
