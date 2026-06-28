{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-1,1920x1080@240,0x0,1, bitdepth, 10"
      "DP-3,1920x1080@240,1920x0,1, bitdepth, 10"
      "HDMI-A-1,1920x1080@60,0x1080,1"
    ];
  };
}
