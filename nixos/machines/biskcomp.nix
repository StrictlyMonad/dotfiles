{
  imports = [
    ../internet-computer.nix
    ../raspberry-pi.nix
    ../base.nix
  ];

  networking.hostName = "biskcomp";
  hardware.video.hidpi.enable = true;

  system.stateVersion = "21.05";
}
