{ config, pkgs, ...}: {
  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1,2256x1504@60,960x2160,1"
  ];
}
