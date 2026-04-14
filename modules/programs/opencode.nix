{ pkgs, ... }:
{
  home.packages = with pkgs; [
    uv
  ];
  xdg.configFile."opencode/config.json".text = builtins.toJSON {
    mcp = {
      nixos = {
        type = "local";
        command = [ "uvx" "mcp-nixos" ];
      };
    };
  };
}
