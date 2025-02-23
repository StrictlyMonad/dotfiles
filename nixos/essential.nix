{ pkgs, ... }:
let
  my-python-packages = python-packages: with python-packages; [
    appdirs
    ipdb
    ipython
    numpy
    openpyxl
    pip
    requests
    tox
    virtualenv
    virtualenvwrapper
  ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in
{
  nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
    python-with-my-packages
    (emacs29.override {
      withNativeCompilation = true;
      withTreeSitter = true;
    })

    # Tools
    automake
    bazel
    bind
    binutils
    cmake
    dex
    direnv
    dpkg
    fd
    file
    gawk
    gcc
    gdb
    gitFull
    git-sync
    gnumake
    htop
    inotify-tools
    ispell
    jq
    lsof
    magic-wormhole-rs
    ncdu
    neofetch
    nix-index
    pass
    patchelf
    pciutils
    pstree
    rclone
    rcm
    ripgrep
    silver-searcher
    tmux
    tzupdate
    udiskie
    unzip
    usbutils
    wget
    yubikey-manager
  ];
}
