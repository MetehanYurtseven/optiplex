{ ... }:
let
  admins = import ./admin.nix;
in {
  imports = [
    ./modules/disk-config.nix
    ./modules/nix.nix
    ./modules/sudo.nix
    ./modules/zsh.nix
    ./modules/ssh.nix
    ./modules/nvim.nix
  ];

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
    5353
  ];
  networking.firewall.allowedTCPPorts = [
    8123
    21064
  ];

  system.stateVersion = "26.05";
}
