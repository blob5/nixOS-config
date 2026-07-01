{ pkgs, ... }:
{
  home.packages = with pkgs; [
    uv
    opencode
    lmstudio
    # LSP servers (now at top-level; nodePackages removed)
    typescript-language-server
    vscode-langservers-extracted  # provides HTML, CSS, JSON, ESLint, etc.
    nixd
  ];

  xdg.configFile."opencode/config.json".text = builtins.toJSON {
    plugin = [
      "opencode-lmstudio@0.3.1"
    ];

    mcp = {
      nixos = {
        type = "local";
        command = [ "uvx" "mcp-nixos" ];
      };
      "you-com" = {
        type = "remote";
        url = "https://api.you.com/mcp?profile=free";
      };
    };

    permission = {
      webfetch = "allow";
      websearch = "allow";
    };

    # LSP configuration – each server must include 'extensions'
    lsp = {
      typescript = {
        command = [ "typescript-language-server" "--stdio" ];
        extensions = [ ".ts" ".tsx" ];
      };
      javascript = {
        command = [ "typescript-language-server" "--stdio" ];
        extensions = [ ".js" ".jsx" ];
      };
      html = {
        command = [ "vscode-html-language-server" "--stdio" ];
        extensions = [ ".html" ".htm" ];
      };
      css = {
        command = [ "vscode-css-language-server" "--stdio" ];
        extensions = [ ".css" ];
      };
      json = {
        command = [ "vscode-json-language-server" "--stdio" ];
        extensions = [ ".json" ".jsonc" ];
      };
      nix = {
        command = [ "nixd" ];
        extensions = [ ".nix" ];
      };
    };
  };
}