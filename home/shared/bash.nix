{ pkgs, ... }:
{
  # Installs bashInteractive from nixpkgs; the login shell is set per host.
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyFileSize = 100000;
    historySize = 10000;

    shellAliases = {
      emacs = "emacsclient -c -a emacs";
    };

    # Runs for every shell, including non-interactive and non-login ones.
    # Secrets live in 0600 files outside the repo and are read at startup.
    bashrcExtra = ''
      [ -r ~/.config/secrets/hcloud-token ] && export HCLOUD_TOKEN="$(< ~/.config/secrets/hcloud-token)"
      [ -r ~/.config/secrets/mc-host-qntifyi ] && export MC_HOST_qntifyi="$(< ~/.config/secrets/mc-host-qntifyi)"
    '';

    initExtra = ''
      # \e]2;\w\a sets the window title to the working directory (Ghostty's own
      # title feature is off, see ghostty.nix).
      PS1='\[\e]2;\w\a\]\[\e[1;32m\]\u (\[\e[0m\]\[\e[34m\]\W\[\e[m\]\[\e[1;32m\])\[\e[0m\] $ '

      whoseport() {
        ${pkgs.lsof}/bin/lsof -i ":$1" | grep LISTEN
      }
    '';
  };

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    GOPATH = "$HOME/go";
    GOBIN = "$HOME/go/bin";
  };
  home.sessionPath = [ "$HOME/go/bin" ];

  # Ctrl-R searches history with fzf (also Ctrl-T for files, Alt-C for dirs).
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };
}
