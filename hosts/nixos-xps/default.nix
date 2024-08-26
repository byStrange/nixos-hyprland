{
  pkgs,
  config,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      # Generic Hardware Config
      ./hardware-configuration.nix

      # Common config
      ../common/core

      # Optional configs
      ../common/optional/hyprland.nix

      # User config
      ../common/users/rahmatullo # Replace with your actual user config path
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  # Bootloader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.configurationLimit = 15;
  boot.loader.systemd-boot.configurationLimit = 15;
  boot.supportedFilesystems = ["ntfs"];

  networking.hostName = "your-hostname"; # Define your hostname.

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Use modesetting driver for integrated graphics
  services.xserver.videoDrivers = ["modesetting"];
  services.xserver.xkbOptions = "ctrl:nocaps";
  console.useXkbConfig = true;
  hardware.bluetooth.enable = true;

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.options = "ctrl:nocaps";
    xkb.layout = "us";
    xkb.variant = "";
    displayManager.gdm.enable = true;
  };

  system.stateVersion = "23.11";
}
