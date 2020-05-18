{ config, pkgs, ... }:
let
  mspyls = pkgs.callPackage ../nixpkgs/ms-python.nix {};
  #   extractNuGet = pkgs.callPackage ./nixpkgs/extract-nuget.nix {};
  # };
in
{
  environment = {
    shells = [ pkgs.bash ];

    systemPackages = with pkgs; [
      gnupg              # encryption tool

      git                # version control
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
      mitmproxy
      unstable.hugo      # website generator
      woeusb             # making windows bootables
      jq                 # json handler
      peek               # screen recording
      screenkey          # show keys pressed on screen
      protobuf           # dealing with Google's Protobuf format
      wireguard          # vpn
      libqrencode        # encode wireguard configs to qr
      ws                 # websocket tool
      rclone
      inotifyTools
      powerstat
      dotnet-sdk
      mspyls

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
      go_1_13 # golang programming language
      dep     # depedency manager for golang
      gotools # helper cli for golang (auto importing and more)
      golangci-lint

      conda
      pre-commit
      (python3.withPackages (ps: with ps; [
        pyflakes
        autopep8
        pylint
        black
        isort

        requests
        # pytorch
        # torchvision
        epc
        pygments
        jupyter
        ipython
        pandas
        matplotlib
      ]))

      gcc_multi
      # elmPackages.elm
      # elmPackages.elm-format
      nodejs
      nodePackages.gulp
      nodePackages."@vue/cli"
      leiningen  # clojure management
      clojure
      sass
      rustup

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

      gsmartcontrol
      glxinfo

      udiskie
      stress-ng
    ];
  };
}
