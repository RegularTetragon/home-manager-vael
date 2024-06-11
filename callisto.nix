{ config, pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,2256x1504@60,960x2160,1"
    ];
    input.kb_variant = "colemak_dh";
    input.kb_options = "caps:swapescape";
  };
}
