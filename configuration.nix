# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ 
  config, 
  pkgs, 
  ...
}:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.localBinInPath = true;  


  # BOOTLOADER
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
    
  # NETWORKING
  networking.networkmanager.enable = true;

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

  # USER(S)
  users.users.caiigee = {
    isNormalUser = true;
    description = "caiigee";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    packages = with pkgs; [];
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
  
  # Enabling the OpenSSH daemon.
  services.openssh.enable = true;  
  
  # DO NOT CHANGE!
  system.stateVersion = "24.05";
}
