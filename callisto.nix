{ config, pkgs, ... }:
{
  programs.niri.settings.input = {
    keyboard = {
      xkb = {
        layout = "us";
        variant = "colemak_dh";
        options = "caps:swapescape";
      };
    };
  };
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,2256x1504@60,0x0,1"

      #      "eDP-1,1920x1080@60,0x0,1,mirror,DP-3"
      #      "DP-3,1920x1080@50,0x0,1"
    ];
    "device" = [
      {
        name = "at-translated-set-2-keyboard";
        kb_options = "caps:swapescape";
        kb_variant = "colemak_dh";
      }
    ];
  };
}
