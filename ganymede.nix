{ config, pkgs, ...}: {
  wayland.windowManager.hyprland.settings.monitor = [
    "monitor=DP-1,3840x2160@144,0x0,1"
    "monitor=DP-3,1920x1080@240,3840x0,1,transform,3"
    "monitor=HDMI-A-1,1920x1080@240,-1080x0,1,transform,1"
    "monitor=HDMI-A-2,1920x1080@60,0x2160,1"
 ];
}
