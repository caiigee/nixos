# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  services.openssh.enable = true;

  # BOOTLOADER
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # NETWORKING
  networking.networkmanager.enable = true;
  networking.hostName = "flowX16";

  # LOCALE, TIME & KEYBOARD
  time.timeZone = "Europe/Zagreb";
  i18n.defaultLocale = "en_IE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IE.UTF-8";
    LC_IDENTIFICATION = "en_IE.UTF-8";
    LC_MEASUREMENT = "en_IE.UTF-8";
    LC_MONETARY = "en_IE.UTF-8";
    LC_NAME = "en_IE.UTF-8";
    LC_NUMERIC = "en_IE.UTF-8";
    LC_PAPER = "en_IE.UTF-8";
    LC_TELEPHONE = "en_IE.UTF-8";
    LC_TIME = "en_IE.UTF-8";
  };
  console.keyMap = "croat";

  # USER(S)
  users.users.caiigee = {
    isNormalUser = true;
    description = "caiigee";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
    ];
  };

  # SOFTWARE
  nixpkgs.config.allowUnfree = true;
  virtualisation.waydroid.enable = true;
  environment.systemPackages = with pkgs; [
    lact
  ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  programs.adb.enable = true;
  services.gnome.evolution-data-server.enable = true;
  #  programs.gamemode.enable = true;
  #  programs.gamescope.enable = true;

  # NIX
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  # AUDIO?
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # BLUETOOTH?
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # ASUS
  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  # NVIDIA
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently "beta quality", so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:10:0:0";
    };
  };

  # Power button:
  # services.logind.services.Login.HandlePowerKey = "ignore";
  services.logind.powerKey = "ignore";

  # On the go:
  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = [ "on-the-go" ];
      hardware.nvidia = {
        prime.offload.enable = lib.mkForce true;
        prime.offload.enableOffloadCmd = lib.mkForce true;
        prime.sync.enable = lib.mkForce false;
        powerManagement.finegrained = lib.mkForce true;
      };
    };
  };

  # DO NOT CHANGE!
  system.stateVersion = "24.05";
}
