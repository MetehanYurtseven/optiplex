{ pkgs, ... }:
{
  fileSystems = {
    "/mnt/hdd2" = {
      device = "/dev/disk/by-label/HDD2";
      fsType = "ext4";
      options = [ "defaults" "noatime" "errors=remount-ro" "nofail" "x-systemd.device-timeout=10s" ];
    };
    "/mnt/hdd3" = {
      device = "/dev/disk/by-label/HDD3";
      fsType = "ext4";
      options = [ "defaults" "noatime" "errors=remount-ro" "nofail" "x-systemd.device-timeout=10s" ];
    };

    "/mnt/storage" = {
      device = "/mnt/hdd2:/mnt/hdd3";
      fsType = "fuse.mergerfs";
      depends = [ "/mnt/hdd2" "/mnt/hdd3" ];
      options = [
        "cache.files=off"
        "category.create=pfrd"
        "func.getattr=newest"
        "dropcacheonclose=false"
        "minfreespace=50G"
        "branches-mount-timeout=30"
        "branches-mount-timeout-fail=true"
        "x-systemd.mount-timeout=45s"
        "fsname=mergerfs"
        "nofail"
      ];
    };
  };

  environment.systemPackages = [ pkgs.mergerfs ];

  # prevents docker from starting before mounts
  systemd.services.docker = {
    after = [ "mnt-storage.mount" ];
    requires = [ "mnt-storage.mount" ];
  };
}
