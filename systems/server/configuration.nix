{ pkgs, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.swraid.enable = true;
  
  # SSH  
  services.openssh = { 
    enable = true; 
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ]; 
    settings = {
      PermitRootLogin = "prohibit-password";
    };
  };
  environment.variables = {
    TERM = "xterm-kitty";
  };

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
  
  # USERS
  users.users.root = {
    packages = with pkgs; [ git ];
  };
  
  # SECURITY
  environment.extraInit = "umask 0077";

  system.stateVersion = "25.05";
}
