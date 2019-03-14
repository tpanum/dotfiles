{ config, pkgs, ... }:
{
  environment = {
    shells = [ pkgs.bash ];

    systemPackages = with pkgs; [
      gnupg                # encryption tool
      git                  # version control
      exiftool             # reading image fileheaders
      file                 # file inspection
      curl                 # http interaction
      proxychains          # proxy that is easily managed by curl
      tree                 # directory tree inspector
      ripgrep              # alternative to grep
      fzf                  # fuzzy matcher used for reverse bash search
      htop                 # performance inspection
      powertop             # battery drain inspection
      psmisc               # needed for `pkill`
      cdrkit               # `genisofolder` tool for creating iso images
      sshfs                # mount fileshares through ssh
      pandoc               # document converter
      usbutils             # `lsusb` tool used for displaying usb information
      bind                 # needed for `nslookup`
      samba                # samba client
      nfs-utils            # accessing nfs
      borgbackup           # backup solution
      docker_compose       # easy and simple docker orchestration
      parted               # needed for gnome3 disks util
      winusb               # tool for creating bootable windows usbs
      imagemagick          # image resizing and manipulation
      wmctrl               # controlling windows (i.e. shutdown firefox on boot)
      proselint
      gnumake
      teensy-loader-cli
      tcpdump
      traceroute

      getmail


      # altcoins.aeon
      lsof
      nmap
      hugo                 # website generator
      woeusb               # making windows bootables
      jq                   # json handler
      peek                 # screen recording
      screenkey            # show keys pressed on screen
      protobuf
      wireguard
      xournal

      # spellchecking
      aspell               # spellchecking
      aspellDicts.en       # ... for english
      aspellDicts.da       # ... for danish
      (hunspellWithDicts (with hunspellDicts; [en-us]))
      enchant

      # password
      pass
      rofi-pass

      # development
      sqlite  # small file-oriented sql database
      go      # golang programming language
      dep     # depedency manager for golang
      gotools # helper cli for golang (auto importing and more)
      golangci-lint
      (python3.withPackages (ps: with ps; [
      selenium
      virtualenvwrapper
      requests
      autopep8
      importmagic
      epc
      django
      pygments
    ]))
    geckodriver
      gcc_multi
      # elmPackages.elm
      # elmPackages.elm-format
      nodejs
      nodePackages.gulp
      nodePackages.vue-cli

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
      texlive.combined.scheme-full
    ];
  };
}
