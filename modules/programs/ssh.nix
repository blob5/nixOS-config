{ ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."*" = {
      AddKeysToAgent = "no";
      Compression = "no";
      ControlPath = "~/.ssh/master-%r@%n:%p";
      ForwardAgent = "no";
      HashKnownHosts = "no";
      ServerAliveCountMax = 3;
      ServerAliveInterval = 30;
      UserKnownHostsFile = "~/.ssh/known_hosts";
    };
    settings."github.com" = {
      hostname = "ssh.github.com";
      port = 443;
      user = "git";
    };
  };
}
