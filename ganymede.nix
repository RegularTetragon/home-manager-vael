{ config, pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
    "DP-1,3840x2160@144,0x0,1,bitdepth,10"
    "DP-3,1920x1080@240,3840x0,1,transform,1"
    "DP-2,1920x1080@240,-1080x0,1,transform,3"
    "HDMI-A-2,1920x1080@60,960x2160,1"
   ];
 };
}
