{ ... }:

{
  programs.ssh = {
    enable = true;

    extraConfig = ''
      # Force GitHub SSH over HTTPS port 443:
      # https://docs.github.com/en/authentication/troubleshooting-ssh/using-ssh-over-the-https-port
      Host github.com
        HostName ssh.github.com
        Port 443
        User git
    '';
  };
}
