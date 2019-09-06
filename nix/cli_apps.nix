{ config, pkgs, ... }:
{
  environment = {
    shells = [ pkgs.bash ];

    systemPackages = with pkgs; [
      gnupg              # encryption tool

      git                # version control
      exiftool           # reading image fileheaders
      file               # file inspection
      curl               # http interaction
      proxychains        # proxy that is easily managed by curl
      tree               # directory tree inspector
      ripgrep            # alternative to grep
      fzf                # fuzzy matcher used for reverse bash search
      htop               # performance inspection
      psmisc             # needed for `pkill`
      cdrkit             # `genisofolder` tool for creating iso images
      sshfs              # mount fileshares through ssh
      pandoc             # document converter
      usbutils           # `lsusb` tool used for displaying usb information
      bind               # needed for `nslookup`
      samba              # samba client
      nfs-utils          # accessing nfs
      borgbackup         # backup solution
      docker_compose     # easy and simple docker orchestration
      parted             # needed for gnome3 disks util
      winusb             # tool for creating bootable windows usbs
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
      hugo               # website generator
      woeusb             # making windows bootables
      jq                 # json handler
      peek               # screen recording
      screenkey          # show keys pressed on screen
      protobuf           # dealing with Google's Protobuf format
      wireguard          # network sniffing
      ws                 # websocket tool
      rclone

      # networking
      whois
      wavemon
      iperf

      # photos
      dcraw
      libjpeg

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
      exercism
      sqlite  # small file-oriented sql database
      go_1_12      # golang programming language
      dep     # depedency manager for golang
      gotools # helper cli for golang (auto importing and more)
      golangci-lint

      (python3.withPackages (ps: with ps; [
        python-language-server
        requests
        autopep8
        importmagic
        pytest
        pytorch
        torchvision
        epc
        pygments
      ]))

      conda
      python37Packages.conda

      gcc_multi
      # elmPackages.elm
      # elmPackages.elm-format
      nodejs
      nodePackages.gulp
      nodePackages."@vue/cli"
      leiningen  # clojure management
      clojure
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
      texlive.combined.scheme-full

      travis
      weechat

      # virtualization
      unstable.packer
    ];
  };
}
