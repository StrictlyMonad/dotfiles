{ config, pkgs, options, ... }:
let
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
  my-python-packages = python-packages: with python-packages; [
    appdirs
    ipdb
    ipython
    numpy
    openpyxl
    pip
    python-language-server
    requests
    tensorflow
    tox
    virtualenv
    virtualenvwrapper
  ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
  taffySource = pkgs.lib.sourceByRegex ../dotfiles/config/taffybar [
    "taffybar.hs" "imalison-taffybar.cabal"
  ];
  xmonadSource = ../dotfiles/config/xmonad;
in
{
  nixpkgs.overlays = [
    (import ./overlays.nix)
    (import ../dotfiles/config/taffybar/taffybar/overlay.nix)
    (import ../dotfiles/config/xmonad/overlay.nix)
  ];

  # Allow all the things
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  # Security and networking
  security.sudo.wheelNeedsPassword = false;
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  # Audio
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.opengl.driSupport32Bit = true;

  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/Los_Angeles";

  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      emojione
      fira-mono
      font-awesome-ttf
      noto-fonts-emoji
      roboto
      source-code-pro
      source-sans-pro
      source-serif-pro
      twemoji-color-font
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "Roboto" ];
        serif     = [ "Source Serif Pro" ];
      };
      ultimate = {
        enable = false;
      };
    };
  };

  environment.systemPackages = with pkgs; [

    # Applications
    calibre
    dfeet
    discord
    emacs
    firefox
    gitter
    google-chrome
    hexchat
    keybase-gui-fixed
    kleopatra
    kodi
    libreoffice
    lxappearance
    pulseeffects
    quassel
    rxvt_unicode
    slack-appindicator
    simplescreenrecorder
    spotify
    termite
    vlc
    xfce.thunar
    wire-desktop
    zoom-us

    # Appearance
    numix-icon-theme-circle
    gnome3.adwaita-icon-theme
    hicolor-icon-theme
    plasma5.breeze-gtk
    plasma5.breeze-qt5
    gnome-breeze

    # Desktop
    (haskellPackages.callCabal2nix "imalison-taffybar" taffySource { })
    (haskellPackages.callCabal2nix "imalison-xmonad" xmonadSource { })
    haskellPackages.status-notifier-item
    autorandr
    betterlockscreen
    blueman
    clipit
    compton
    feh
    gnome3.gpaste
    kdeconnect
    libnotify
    lxqt.lxqt-powermanagement
    networkmanagerapplet
    customizable-notify-osd
    pasystray-appindicator
    pinentry
    pommed_light
    rofi
    rofi-pass
    skippy-xd
    synergy
    udiskie
    volnoti

    # xorg
    wmctrl
    xclip
    xdotool
    xorg.xev
    xorg.xkbcomp
    xorg.xwininfo
    xsettingsd

    # Audio
    pulsemixer
    pavucontrol
    playerctl

    # Haskell
    cabal-install
    cabal2nix
    ghc
    stack
    haskellPackages.hasktags
    # haskell.compiler.ghc863

    # Scala
    sbt
    scala

    # Node
    nodePackages.npm
    nodejs

    # Rust
    cargo

    # Clojure
    boot
    leiningen

    # Ruby
    ruby

    # Tools
    automake
    bazaar
    binutils
    dex
    direnv
    dpkg
    emacs26Packages.cask
    fd
    file
    gcc
    gdb
    gitAndTools.git-sync
    gitAndTools.git-fame
    gitAndTools.hub
    gitFull
    glxinfo
    gnumake
    gnupg
    gparted
    htop
    inotify-tools
    ispell
    jq
    mercurial
    networkmanager-openvpn
    ncdu
    neofetch
    openvpn
    parallel
    pass
    patchelf
    pciutils
    plasma-workspace
    powertop
    prometheus_2
    pscircle
    python-with-my-packages
    qt5.qttools
    rcm
    rr
    scrot
    silver-searcher
    stow
    tmux
    unzip
    usbutils
    valgrind
    wget
    zsh

    # Nix
    nix-prefetch-git

    # Miscellaneous
    android-udev-rules
    librsvg
    transmission-gtk
  ];

  # XXX: Plasma seems to set this
  # environment.variables = {
  #   GDK_PIXBUF_MODULE_FILE = "${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";
  # };
  # Enabling zsh will clobber path because of the way it sets up /etc/zshenv
  # programs.zsh.enable = true;
  # Instead we just make sure to source profile from zsh

  environment.etc."zshenv".text =
    ''
      if [ -n "$__ETC_PROFILE_DONE" ]; then return; fi
      source /etc/profile
    '';

  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.adb.enable = true;

  services.tlp.enable = true;
  services.acpid.enable = false;

  services.openssh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      domain = true;
      userServices = true;
    };
  };

  services.gnome3.at-spi2-core.enable = true;

  services.kbfs.enable = true;

  services.autorandr.enable = true;

  services.locate.enable = true;

  services.xserver = {
    exportConfiguration = true;
    enable = true;
    layout = "us";
    desktopManager = {
      plasma5.enable = true;
      gnome3.enable = true;
      default = "none";
    };
    windowManager = {
      default = "xmonad";
      session = [{
        name = "xmonad";
        start = ''
          /usr/bin/env imalison-xmonad &
          waitPID=$!
        '';
      }];
    };
    displayManager = {
      sddm = {
        enable = true;
      };
      sessionCommands = ''
        systemctl --user import-environment GDK_PIXBUF_MODULE_FILE
      '';
    };

  };

  users.extraUsers = let
    extraGroups = [
      "audio"
      "adbusers"
      "disk"
      "networkmanager"
      "systemd-journal"
      "video"
      "wheel"
    ];
    userDefaults = {
      inherit extraGroups;
      group = "users";
      isNormalUser = true;
      createHome = true;
      shell = pkgs.zsh;
    };
  in {
    imalison = userDefaults // {
      name = "imalison";
      uid = 1000;
      home = "/home/imalison";
      shell = pkgs.zsh;
    };
    kat = userDefaults // {
      name = "kat";
      uid = 1001;
      home = "/home/kat";
      shell = pkgs.zsh;
    };
  };

  system.stateVersion = "18.03";
}
