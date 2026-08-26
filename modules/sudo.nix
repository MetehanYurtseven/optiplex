{ ... }:
{
  security.pam.sshAgentAuth = {
    enable = true;
    authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
  };
  security.pam.services.sudo = {
    sshAgentAuth = true;
    unixAuth = false;
  };
}
