{ config, pkgs, ... }:
let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  minionpro = pkgs.callPackage ../nixpkgs/fonts/minionpro.nix {};
  # texlive = pkgs.lib.overrideDerivation (pkgs.texlive.combine {
  #   inherit (pkgs.texlive)
  #   scheme-full;
  #      minionpro.pkgs = [minionpro];
  #    }) (oldAttrs: {
  #    postBuild = ''
  #      # Save the udpmap.cfg because texlive.combine removes it.
  #      cat $out/share/texmf/web2c/updmap.cfg > $out/share/texmf/web2c/updmap.cfg.1
  #      '' + oldAttrs.postBuild + ''
  #      # Move updmap.cfg into its original place and rerun mktexlsr, so that kpsewhich finds it
  #      rm $out/share/texmf/web2c/updmap.cfg || true
  #      cat $out/share/texmf/web2c/updmap.cfg.1 > $out/share/texmf/web2c/updmap.cfg
  #      rm $out/share/texmf/web2c/updmap.cfg.1
  #      perl `type -P mktexlsr.pl` $out/share/texmf

  #      yes | perl `type -P updmap.pl` --sys --syncwithtrees --force || true
  #      perl `type -P updmap.pl` --sys --enable Map=MinionPro.map --enable Map=MyriadPro.map

  #      # Add minionpro/myriad
  #      #echo "Map MinionPro.map" >> $out/share/texmf/web2c/updmap.cfg
  #      #echo "Map MyriadPro.map" >> $out/share/texmf/web2c/updmap.cfg

  #      # Regenerate .map files.
  #      perl `type -P updmap.pl` --sys
  #    '';
  #    });
  mozPkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
in
{
  environment = {
    shells = [ pkgs.bash ];

    systemPackages = with pkgs; [
      gnupg              # encryption tool

      git                # version control
      git-lfs            # extension for larger files
      exiftool           # reading image fileheaders
      file               # file inspection
      curl               # http interaction
      wget
      proxychains        # proxy that is easily managed by curl
      tree               # directory tree inspector
      ripgrep            # alternative to grep
      pdfgrep
      fzf                # fuzzy matcher used for reverse bash search
      htop               # performance inspection
      atop               # performance inspection
      psmisc             # needed for `pkill`
      cdrkit             # `genisofolder` tool for creating iso images
      sshfs              # mount fileshares through ssh
      pandoc             # document converter
      usbutils           # `lsusb` tool used for displaying usb information
      bind               # needed for `nslookup`
      samba              # samba client
      nfs-utils          # accessing nfs
      borgbackup         # backup solution
      duplicacy
      docker-compose     # easy and simple docker orchestration
      parted             # needed for gnome3 disks util
      woeusb-ng          # tool for creating bootable windows usbs
      imagemagick        # image resizing and manipulation
      wmctrl             # controlling windows (i.e. shutdown firefox on boot)
      imagemagick        # image manipulation from cli
      ffmpeg             # video manipulation
      gnumake            # classic make
      teensy-loader-cli  # application for flashing teensy (ergodox)
      tcpdump            # tcp inspection
      traceroute         # understand routing
      libheif            # apple image format
      cloc               # count lines of code
      fd                 # alternative to find
      lsof
      nmap               # port scanner
      # mitmproxy
      unstable.hugo      # website generator
      jq                 # json handler
      peek               # screen recording
      mpv                # show webcam on screen
      screenkey          # show keys pressed on screen
      protobuf           # dealing with Google's Protobuf format
      wireguard-tools          # vpn
      qrencode        # encode wireguard configs to qr
      unstable.rclone
      inotifyTools
      powerstat


      # rust
      mozPkgs.latest.rustChannels.stable.rust
      rust-analyzer

      # networking
      whois
      wavemon
      iperf
      mosh               # ssh alternative

      # photos
      libjpeg

      # spellchecking
      aspell               # spellchecking
      aspellDicts.en       # ... for english
      aspellDicts.da       # ... for danish
      (hunspellWithDicts (with hunspellDicts; [en-us]))
      enchant

      # password
      (pass.withExtensions (ext: [
        ext.pass-otp
        ext.pass-genphrase
      ]))
      zbar
      rofi-pass

      # development
      exercism
      sqlite  # small file-oriented sql database
      libspatialite
      go # golang programming language
      dep     # depedency manager for golang
      gotools # helper cli for golang (auto importing and more)
      golangci-lint
      sqlint

      conda
      micromamba
      pipenv
      unstable.ruff
      pre-commit
      (python3.withPackages (ps: with ps; [
        autopep8
        black
        epc
        ipython
        isort
        jupyter
        matplotlib
        pandas
        pyflakes
        pygments
        pylint
        python-lsp-server
        pytest
        requests
        mypy
        pydantic
      ]))
      pyright

      postgresql
      dbeaver
      throttled
      argo
      kubectl
      envsubst
      kubeseal
      kubernetes-helm
      k9s
      yq-go

      bazel_6

      gcc_multi
      elmPackages.elm
      elmPackages.elm-live
      elmPackages.elm-format
      elmPackages.create-elm-app

      nodejs
      nodePackages.gulp
      sass

      # extraction + compression
      unrar
      zip
      unzip
      dtrx
      pv
      p7zip

      # file systems
      ntfs3g
      ncdu # figure out where disk space goes

      # typography
      # texlive.combined.scheme-full
      # texlive
      vale

      gsmartcontrol
      glxinfo

      udiskie
      stress-ng
      apktool
    ];
  };
}
