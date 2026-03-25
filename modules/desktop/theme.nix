{ pkgs, lib, ... }:

let
  gtkThemeName = "adw-gtk3-dark";

  palette = {
    mantle   = "#181825";
    base     = "#1e1e2e";
    surface0 = "#313244";
    surface1 = "#45475a";
    text     = "#cdd6f4";
    overlay2 = "#9399b2";
    accent   = "#f38ba8";
    border   = "rgba(205, 214, 244, 0.22)";
  };

  inherit (palette) mantle base surface0 surface1 text overlay2 accent border;

  # Helper to generate CSS color variable definitions
  defineColor = name: value: "@define-color ${name} ${value};";

  colorDefs = lib.concatStringsSep "\n" (map (pair: defineColor (builtins.elemAt pair 0) (builtins.elemAt pair 1)) [
    [ "window_bg_color"            mantle ]
    [ "window_fg_color"            text   ]
    [ "view_bg_color"              mantle ]
    [ "view_fg_color"              text   ]
    [ "card_bg_color"              base   ]
    [ "card_fg_color"              text   ]
    [ "dialog_bg_color"            mantle ]
    [ "dialog_fg_color"            text   ]
    [ "headerbar_bg_color"         mantle ]
    [ "headerbar_fg_color"         text   ]
    [ "popover_bg_color"           base   ]
    [ "popover_fg_color"           text   ]
    [ "accent_color"               accent ]
    [ "accent_bg_color"            accent ]
    [ "accent_fg_color"            mantle ]
    [ "theme_bg_color"             mantle ]
    [ "theme_fg_color"             text   ]
    [ "borders"                    border ]
    [ "sidebar_bg_color"           base   ]
    [ "sidebar_fg_color"           text   ]
    [ "sidebar_backdrop_color"     base   ]
    [ "secondary_sidebar_bg_color" base   ]
    [ "secondary_sidebar_fg_color" text   ]
  ]);

  # Sidebar selectors share identical rules — define once
  sidebarSelectors = [
    ".sidebar-pane"
    ".sidebar-pane:backdrop"
    ".navigation-sidebar.background"
    "filechooser placessidebar"
    "filechooser placessidebar:backdrop"
  ];

  # Selectors for the split-view adjacent pane rules
  isolatedSelectors =
    let
      panes = [ ".content-pane" ".sidebar-pane" ];
      states = [ "" ":backdrop" ];
    in
    lib.concatMap (a: lib.concatMap (b: map (s:
      ":not(.isolated) > ${a} :not(.isolated) > ${b}${s}"
    ) states) panes) panes;

  navRowSelectors = [
    "placessidebar .navigation-sidebar > row"
    ".navigation-sidebar > row"
    ".navigation-sidebar row.activatable"
  ];

  navRowHoverSelectors  = map (s: "${s}:hover")    navRowSelectors;
  navRowActiveSelectors = map (s: "${s}:selected") navRowSelectors ++ [
    "placessidebar .navigation-sidebar > row:checked"
    ".navigation-sidebar > row:checked"
  ];

  # Reusable dialog button selector list
  dialogButtonSelectors = [
    "dialog button"
    "dialog actionbar button"
    ".dialog-action-area button"
    "messagedialog button"
    ".message-dialog button"
    "window.dialog button"
    ".csd.dialog button"
  ];

  # Build a CSS rule block from a list of selectors and a property string
  rule = selectors: props:
    "${lib.concatStringsSep ",\n" selectors} {\n${props}\n}";

  gtkCss = ''
    ${colorDefs}

    window,
    .background,
    :root {
      --sidebar-bg-color: ${base};
      --sidebar-fg-color: ${text};
      --sidebar-backdrop-color: ${base};
      --sidebar-border-color: ${border};
      --secondary-sidebar-bg-color: ${base};
      --secondary-sidebar-fg-color: ${text};
      --secondary-sidebar-backdrop-color: ${base};
      --secondary-sidebar-border-color: ${border};
    }

    ${rule sidebarSelectors ''
      background-color: ${base};
      color: ${text};''}

    ${rule isolatedSelectors ''
      background-color: ${base};
      color: ${text};''}

    ${rule navRowSelectors ''
      background-color: transparent;
      color: ${text};''}

    ${rule navRowHoverSelectors ''
      background-color: ${surface0};''}

    ${rule navRowActiveSelectors ''
      background-color: ${surface1};''}

    button {
      color: @theme_fg_color;
      background-color: @theme_bg_color;
      border: 0.1em solid @borders;
    }

    ${rule dialogButtonSelectors ''
      border-width: 1px;
      border-style: solid;
      border-color: @borders;
      border-radius: 8px;
      box-shadow: none;
      background-image: none;
      background-color: ${surface0};
      color: ${text};''}

    ${rule (map (s: "${s}:hover") dialogButtonSelectors) ''
      border-color: ${overlay2};
      background-color: ${surface1};''}

    ${rule (map (s: "${s}:focus") dialogButtonSelectors) ''
      border-color: ${accent};
      outline: 2px solid rgba(243, 139, 168, 0.45);
      outline-offset: 1px;''}
  '';

  finalGtkCss = pkgs.writeText "gtk.css" gtkCss;

  gtkCssTargets = [
    "gtk-3.0/gtk.css"
    "gtk-3.0/gtk-dark.css"
    "gtk-4.0/gtk.css"
    "gtk-4.0/gtk-dark.css"
  ];
in
{
  gtk = {
    enable = true;
    theme = {
      name    = gtkThemeName;
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name    = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-theme    = gtkThemeName;
  };

  xdg.configFile = builtins.listToAttrs (map (path: {
    name  = path;
    value.source = lib.mkForce finalGtkCss;
  }) gtkCssTargets);

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name         = "kvantum";
  };
}