let
  me = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMc4b7rjerN0+skf7aEH/fnOvqAu+Y49Rk++IQyf1Fy3";
  optiplex = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJExwPzcumfu4cNjGSq2TS0jXJ3nhwZs5PXj1k5Xy5Oi";
in {
  "cloudflare_api_token.age".publicKeys = [ me optiplex ];
}
