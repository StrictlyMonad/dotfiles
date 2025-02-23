# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports = [
    ../full.nix
    ../kat.nix
  ];

  hardware.enableRedistributableFirmware = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  services.xserver = {
      enable = true;
      libinput.enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      videoDrivers = [ "amdgpu" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/cb96b029-df61-45d3-905b-a9435bf446df";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1C5A-4FBB";
    fsType = "vfat";
  };

  networking.hostName = "jay-lenovo";

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  system.stateVersion = "23.05";
}
