{ ... }:
let
  admins = import ./admin.nix;
in {
  imports = [
    ./disk-config.nix
    ./modules/zsh.nix
    ./modules/nix.nix
    ./modules/ssh.nix
    ./modules/nvim.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "optiplex";

  services.openssh.enable = true;

  # Users
  users.users.root.openssh.authorizedKeys.keys = admins;

  users.users."metehan.yurtseven" = {
    isNormalUser = true;
    uid = 1000;

    extraGroups = [ "wheel" "systemd-journal" ];
    openssh.authorizedKeys.keys = admins;
  };

  # Sudo - only using ssh keys
  security.pam.sshAgentAuth = {
    enable = true;
    authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
  };
  security.pam.services.sudo = {
    sshAgentAuth = true;
    unixAuth = false;
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
