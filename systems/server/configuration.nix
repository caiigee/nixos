{...}:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  services.openssh.enable = true;

  # NETWORKING
  networking.networkmanager.enable = true;
  networking.hostName = "server";

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
    ];
  };
  
  system.stateVersion = "25.05";
}
