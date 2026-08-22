
{ lib, ... }:
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = false;

      min-free = 1073741824; # 1 GiB
      max-free = 5368709120; # 5 GiB

      # enable remote deploy from sudo users
      trusted-users = [
        "root"
        "@wheel"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
      randomizedDelaySec = "45min";
    };

    optimise.automatic = true;
  };

  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
}
