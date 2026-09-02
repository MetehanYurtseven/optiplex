{ config, ... }:
{
  age.secrets."cloudflare_api_token".file = ../secrets/cloudflare_api_token.age;

  services.ddclient = {
    enable = true;
    protocol = "cloudflare";
    interval = "5min";
    username = "token";
    passwordFile = config.age.secrets."cloudflare_api_token".path;
    domains = [ "home.yurtseven.me" ];
    zone = "yurtseven.me";
  };
}
