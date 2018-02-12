{ config, pkgs, ... }:

{
  environment = {
    shells = [ pkgs.bash ];

    systemPackages = with pkgs; [
      git                  # version control
      binutils-unwrapped   # basic cli utils
      exiftool             # reading image fileheaders
      file                 # file inspection
      curl                 # http interaction
      tree                 # directory tree inspector
      ripgrep              # alternative to grep
      fzf                  # fuzzy matcher used for reverse bash search
      aspell               # spellchecking
      aspellDicts.en       # ... for english
      aspellDicts.da       # ... for danish
      htop                 # performance inspection
      powertop             # battery drain inspection
      psmisc               # needed for `pkill`
      cdrkit               # `genisofolder` tool for creating iso images
      sshfs                # mount fileshares through ssh
      pandoc               # document converter
      usbutils             # `lsusb` tool used for displaying usb information
      gnome3.nautilus      # file explorer
      bind                 # needed for `nslookup`
      samba                # samba client
      nfs-utils
      borgbackup
      docker_compose


      # development
      sqlite               # small file-oriented sql database
      go_1_9               # golang programming language
      dep                # depedency manager for golang
      gotools              # helper cli for golang (auto importing and more)
      python3              # python 3.X
      nodejs

      # extraction + compression
      unrar
      zip
      unzip
      dtrx

      # typography
      texlive.combined.scheme-full

      # email
      mu
      isync
      gnupg
      msmtp
    ];
  };
}
