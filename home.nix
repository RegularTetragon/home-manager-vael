{ config, pkgs,  ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vael";
  home.homeDirectory = "/home/vael";
  home.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.macchiatoPink;
    name = "Catppuccin-Macchiato-Pink-Cursors";
    x11.enable = true;
    gtk.enable = true;
  };
  fonts.fontconfig.enable = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
      nerdfonts fira-code-nerdfont
      ardour
      firefox
      vscodium
      godot_4
      steamcmd
      discord
      dolphin
      deluge wgnord 
      krita
      lmms
      woeusb-ng ntfs3g
      hyfetch
      audacity
      bitwig-studio
      blender
      vlc
      pavucontrol
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      cura openscad-unstable
      helvum
      ffmpeg
      killall
      pstree
      spotify
      filezilla
      protontricks
      prismlauncher
      grapejuice
      libsForQt5.kpat
      xautoclick
      gimp
      glfw-wayland
      r2modman
      waypipe wayvnc
      osslsigncode
      btop ncdu
      brightnessctl
      hyprcursor
      thunderbird
      dosbox-x
      stable.trenchbroom
      stable.yabridge stable.yabridgectl stable.winetricks stable.wineWowPackages.stable stable.corefonts
      rofi-wayland swww waypaper grim slurp wl-clipboard dunst qt5ct networkmanagerapplet jq
      # language servers and such
      nodePackages.nodejs nodePackages.coc-clangd clang-tools nil
      (retroarch.override {
        cores = with libretro; [
          mgba
          mupen64plus
          dosbox
          dolphin
        ];
      })
  ];


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      exec-once = "swww init & waybar & dunst";
      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        mouse_refocus = false;
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0;
      };
      "input:touchpad" = {
        disable_while_typing = false;
      };
      general = {
        gaps_in = 4;
        gaps_out = 4; 
        "col.active_border" = "rgba(f5bde6ff) rgba(f5bde6ff) 45deg";
        "col.inactive_border" = "rgba(363a4fff)";
        layout = "dwindle";
      };
      decoration = {
        rounding = 12;
        blur = {
          enabled = true;
          size = 4;
          passes = 4;
          ignore_opacity = false;
        };
        inactive_opacity = 0.9;
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1a00)";
      };
      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier, slide"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = "yes";
        preserve_split = true;
      };
      master = {
        new_is_master = true;
      };
      gestures = {
        workspace_swipe = "on";
      };
      device = {
        name = "hid-256c:006d-pen";
        output = "HDMI-A-2";
      };
      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
      ];

      bind = [
        "$mainMod, Return, exec, kitty"
        "$mainMod, C, killactive," 
        "$mainMod, Escape, exit," 
        "$mainMod, E, exec, dolphin"
        "$mainMod, F, exec, firefox"
        "$mainMod, V, togglefloating,"
        "$mainMod, Space, exec, rofi -show drun -show-icons"
        "$mainMod, P, pseudo,"
        "$mainMod, R, togglesplit,"
        ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
        "SHIFT, Print, exec, grim - | wl-copy"

        # Move focus with mainMod + arrow keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"
        "$mainMod CTRL, H, resizeactive, -64 0"
        "$mainMod CTRL, L, resizeactive, 64 0"
        "$mainMod CTRL, K, resizeactive, 0 -64"
        "$mainMod CTRL, J, resizeactive, 0 64"


        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ] ++ builtins.concatLists (
        builtins.genList (
          x:
            let ws  = toString (if x == 0 then 10 else x);
                key = toString x;
            in
            [
              "$mainMod, ${key}, workspace, ${ws}"
              "$mainMod SHIFT, ${key}, movetoworkspace, ${ws}"
            ]
          ) 10
      );
      
      bindle = [
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        ", XF86Search, exec, launchpad"
      ];
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause # the stupid key is called play , but it toggles "
        ", XF86AudioNext, exec, playerctl next "
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      bindm = [
        " $mainMod, mouse:272, movewindow"
        " $mainMod, mouse:273, resizewindow"
      ];
    };
  };
  programs.waybar = {
    enable = true;
    style = ''
    * {
      font-family: "FiraCode Nerd Font";
      font-size: 18;
    }
    window#waybar {
      opacity: 0.9;
      border-radius: 24;
    }
    .modules-right {
      padding: 4px;
    }
    .modules-right > * {
      background: #181926;
      border-radius: 6px;
    }
    .modules-right > * > * {
      padding: 0em 1em 0em 0.5em;
      margin: 2px;
    }
    .modules-right > *:first-child{
      border-radius: 20px 6px 6px 20px;
    }
    .modules-right > *:last-child {
      border-radius: 6px 20px 20px 6px;
    }
    #custom-rofi {
      background: #f5bde6;
      color: #24273a;
      border-radius: 24px;
      border-color: #24273a;
      border: 4px solid;
      padding: 0 1em 0 0.5em;
      font-size: 30;
    }
    #workspaces button.active, #taskbar button.active {
      background: #f5bde6;
      color: #24273a;
      border-radius: 12px;
      border-color: #24273a;
      border: 4px solid;
    }

    '';
    settings =  {
      mainBar = {
        layer = "top";
        position = "bottom";
        margin = "4px";
        height = 48;
        spacing = 2;
        modules-left = [ "custom/rofi" "hyprland/workspaces" "wlr/taskbar"];
        modules-center = [ "hyprland/window" "mpris" ];
        modules-right = [  "bluetooth" "network" "custom/vpn" "wireplumber" "battery" "backlight" "clock"  ];
        "hyprland/workspaces" = {
          format = "{icon}";
        };
        "wlr/taskbar" = {
          on-click = "activate";
          icon-size = 18;
        };
        "custom/rofi" = {
          format = "";
          on-click = "rofi -show run";
        };
        "custom/vpn" = {
          format = "{icon}";
          tooltip-format = "{}";
          format-icons = ["" ""];
          exec = ''
            systemctl list-units openvpn-* --output json | jq --unbuffered --compact-output '{percentage: (if length > 0 then 100 else 0 end), text: (.[].unit // "none") | sub("^openvpn-";"") | sub(".service"; "")}'
          '';
          return-type = "json";
          interval = 15;
        };
        clock = {
          format = "{:%H.%M}";
          tooltip = true;
          tooltip-format = "{:%Y-%m-%d}";
          timezone = "America/New_York";
        };
        wireplumber = {
          format = "{icon}";
          tooltip-format = "{node_name} {volume}%";
          format-muted = "󰝟";
          format-icons = ["" "" ""];
          on-click = "pavucontrol";
          on-click-right = "qpwgraph";
        };
        network = {
          on-click = "nm-connection-editor";
          format-icons = ["󰤯" "󰤯" "󰤟" "󰤢" "󰤨"];
          tooltip-format-wifi = "{essid}";
          format-wifi = "{icon}";
          format-disconnected = "󰤮";
          format-ethernet = "󰛳";
          format-linked = "󰲊";
        };
        bluetooth = {
          format-connected = "󰂰";
          format-on = "󰂯";
          format-off="󰂲";
          on-click = "blueman-manager";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-device-enumerate-connected = "{device_alias}";
        };
        battery = {
          format = " {icon}";
          tooltip-format = "{capacity}%";
          format-charging = "{icon}󱐋";
          format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󱟢"];
        };
        backlight = {
          format = "󰍹";
          tooltip-format="{percent}%";
          format-icons = ["󰃜" "󰃛" "󰃚"  "󰃞" "󰃟" "󰃝" "󰃠"];
        };
      };
    };
  };
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs

    ];
  };
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Macchiato";
    font = {
      package = pkgs.fira-code-nerdfont;
      name = "FiraCode Nerd Font Mono";
    };
    extraConfig = ''
    confirm_os_window_close 0
    '';
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins  = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      catppuccin-nvim
      telescope-nvim
      telescope-coc-nvim
      coc-nvim
      coc-clangd
    ];
    extraConfig = ''
      set nowrap
      set number
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set softtabstop=2
      colorscheme catppuccin-macchiato
      inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    '';
  };
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
    };
  };
  # programs.sm64ex.baserom = /home/vael/roms/n64/baserom.us.z64;
}
