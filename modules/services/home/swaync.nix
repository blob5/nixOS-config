# modules/programs/swaync/swyanc.nix
{ ... }:

{
  services.swaync.enable = true;
  services.swaync.settings = {
    positionX = "right";
    positionY = "top";
    control-center-height = 600;
    control-center-width = 400;
    notification-window-width = 400;
    timeout = 10;
    hide-on-clear = true;
    hide-on-action = true;
  };
}