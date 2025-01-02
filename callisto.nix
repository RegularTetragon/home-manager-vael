{ config, pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
     "eDP-1,2256x1504@60,0x0,1"

#      "eDP-1,1920x1080@60,0x0,1,mirror,DP-3"
#      "DP-3,1920x1080@50,0x0,1"
    ];
    input.kb_variant = "colemak_dh";
    input.kb_options = "caps:escape";
  };
}
