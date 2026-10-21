{ config, lib, ... }:
let
  email = "thomas@panum.dk";

  # Public SSH keys used for commit signing, one per machine. Listed in
  # allowed_signers so `git log --show-signature` can verify them locally.
  signingKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLF28Lj4eBg9tx0+7g6PM0BgKNOvBNvTK+1Cf8GjMQd" # macbook
  ];
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    ignores = [
      # macOS
      ".DS_Store"
      # Emacs backups, autosaves and lock files
      "*~"
      "\\#*\\#"
      ".#*"
      # direnv
      ".direnv/"
    ];

    settings = {
      user = {
        name = "Thomas Kobber Panum";
        inherit email;
        signingkey = "~/.ssh/id_ed25519.pub";
      };
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "${config.xdg.configHome}/git/allowed_signers";
      commit.gpgsign = true;
      commit.verbose = true;

      init.defaultBranch = "main";
      help.autocorrect = "prompt";

      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      push = {
        followTags = true;
        autoSetupRemote = true;
      };
      pull.rebase = true;

      rebase = {
        autoStash = true;
        autoSquash = true;
        updateRefs = true;
      };
      merge.conflictstyle = "zdiff3";
      rerere = {
        enabled = true;
        autoupdate = true;
      };
    };
  };

  xdg.configFile."git/allowed_signers".text =
    lib.concatMapStrings (key: "${email} ${key}\n") signingKeys;
}
