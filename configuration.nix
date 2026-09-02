{ lib, ... }:
let
  admins = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMc4b7rjerN0+skf7aEH/fnOvqAu+Y49Rk++IQyf1Fy3" ];
in {
  imports = lib.filesystem.listFilesRecursive ./modules;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "optiplex";

  services.openssh.enable = true;

  # Users
  users.users = {
    root.openssh.authorizedKeys.keys = admins;
    "metehan.yurtseven" = {
      isNormalUser = true;
      uid = 1000;

      extraGroups = [ "wheel" "systemd-journal" ];
      openssh.authorizedKeys.keys = admins;
    };
  };

  virtualisation.docker.enable = true;
  
  networking.firewall.allowedUDPPorts = [
    5353 # mDNS HomeKit Bridge for HA
  ];
  networking.firewall.allowedTCPPorts = [
    8123 # Home Assistant WebUI
    21064 # HomeKit Bridge for HA
  ];

  system.stateVersion = "26.05";
}
