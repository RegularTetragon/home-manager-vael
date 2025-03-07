{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vael";
  home.homeDirectory = "/home/vael";
  home.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "freeimage-unstable-2021-11-01" ];
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.macchiatoPink;
    name = "catppuccin-macchiato-pink-cursors";
    size = 32;
    x11.enable = true;
    gtk.enable = true;
  };
  fonts.fontconfig.enable = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
      nerd-fonts.fira-code
      ardour
      firefox
      vscodium
      godot_4
      steamcmd
      discord
      nautilus qview
      deluge wgnord 
      krita
      lmms vcv-rack
      hyfetch
      audacity
      bitwig-studio
      blender
      vlc
      ghc
      pavucontrol
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      stable.cura stable.openscad-unstable
      xdg-desktop-portal-gtk
      xdg-desktop-portal
      helvum
      ffmpeg
      organicmaps
      killall
      pstree
      spotify
      filezilla
      protontricks
      prismlauncher
      libsForQt5.kpat
      xautoclick
      stable.sauerbraten
      gimp
      glfw-wayland
      r2modman
      waypipe wayvnc
      osslsigncode
      bambu-studio orca-slicer
      btop ncdu file
      brightnessctl
      hyprcursor hyprpaper hyprpolkitagent
      thunderbird
      dosbox-x
      # trenchbroom
      kdenlive
      dolphin-emu
      gamemode mangohud
      trenchbroom
      lutris
      itch
      sweethome3d.application
      alsa-scarlett-gui
      # stable.freecad
      stable.yabridge stable.yabridgectl stable.winetricks stable.wineWowPackages.waylandFull stable.corefonts
      grim slurp wl-clipboard dunst libsForQt5.qt5ct networkmanagerapplet jq
      kdePackages.qtstyleplugin-kvantum
      (catppuccin-kvantum.override {
        accent = "pink";
        variant = "macchiato";
      })
      hyprpolkitagent
      # language servers and such
      nodePackages.nodejs nodePackages.coc-clangd clang-tools nil
    # (retroarch.override {
    #   cores = with libretro; [
    #     mgba
    #     mupen64plus
    #     dosbox
    #     dolphin
    #   ];
    # })
  ];
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.bash = {
    bashrcExtra = ''
    set -o vi
    bind 'set show-mode-in-prompt on'
    if uwsm check may-start && uwsm select; then
      exec systemd-cat -t uwsm_start uwsm start default
    fi
    '';
    enable = true;
  };

  
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    font = "FiraCode Nerd Font 18";
    package = pkgs.rofi-wayland;
    theme = ./rofi/themes/catppuccin-macchiato.rasi;
    extraConfig = {
      display-drun="   Apps ";
      display-run="   Run ";
      display-window=" 󰕰  Window";
      display-Network=" 󰤨  Network";
      sidebar-mode=true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    package = null;
    portalPackage = null;
    settings = {
      "$mainMod" = "SUPER";
      exec-once = [
        "pkill waybar; waybar"
        "dunst"
        "systemctl --user start hyprpaper.service"
        "systemctl --user start hyprpolkitagent.service"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
      env = [
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_QPA_PLATFORM,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_STYLE_OVERRIDE,kvantum"
        "HYPRCURSOR_THEME,catppuccin-macchiato-pink-cursors"
        "HYPRCURSOR_SIZE,32"
        "WINEPREFIX=${config.home.homeDirectory}/.wine/winecfg"
      ];
      input = {
        kb_layout = "us";
        # follow_mouse = 1;
        # mouse_refocus = 1;
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
        layout = "master";
      };
      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 16;
          passes = 4;
        };
        inactive_opacity = 0.95;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aff)";
        };
      };
      experimental = {
        xx_color_management_v4 = true;
      };
      cursor = {
        no_hardware_cursors = 0;
      };
      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier, popin"
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
        orientation = "center";
        # always_center_master = true;
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
       # "stayfocused, class:^(OrcaSlicer)$,title:^()$"
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
      ];
      layerrule = [
        "blur, waybar"
      ];
      bindr = [
        "$mainMod, Super_L, exec, killall rofi || rofi -show drun -show-icons"
      ];
      bind = [
        "$mainMod, C, killactive," 
        "$mainMod, Escape, exit," 
        "$mainMod, A, exec, nautilus"
        "$mainMod, F, exec, firefox"
        "$mainMod, V, togglefloating,"
        "$mainMod, Space, exec, kitty"
        "$mainMod, P, pseudo,"
        "$mainMod, R, togglesplit,"
        "$mainMod, tab, exec, pkill waybar || waybar"
        ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
        "SHIFT, Print, exec, grim - | wl-copy"

        # master binds
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod CTRL, left, movewindow, l"
        "$mainMod CTRL, right, movewindow, r"
        "$mainMod CTRL, up, movewindow, u"
        "$mainMod CTRL, down, movewindow, d"
        "$mainMod, period, layoutmsg, addmaster"
        "$mainMod, comma, layoutmsg, removemaster"
        "$mainMod SHIFT, left, resizeactive, -64 0"
        "$mainMod SHIFT, right, resizeactive, 64 0"
        "$mainMod SHIFT, up, resizeactive, 0 -64"
        "$mainMod SHIFT, down, resizeactive, 0 64"
        "$mainMod ALT, left,  layoutmsg, orientationleft"
        "$mainMod ALT, right, layoutmsg, orientationright"
        "$mainMod ALT, up,    layoutmsg, orientationtop"
        "$mainMod ALT, down,  layoutmsg, orientationbottom"

        "$mainMod, M, movefocus, l"
        "$mainMod, I, movefocus, r"
        "$mainMod, E, movefocus, u"
        "$mainMod, N, movefocus, d"
        "$mainMod, J, movewindow, l"
        "$mainMod, Y, movewindow, r"
        "$mainMod, U, movewindow, u"
        "$mainMod, L, movewindow, d"
        "$mainMod, semicolon, layoutmsg, addmaster"
        "$mainMod, O, layoutmsg, removemaster"
        "$mainMod, K, resizeactive, -64 0"
        "$mainMod, period, resizeactive, 64 0"
        "$mainMod, comma, resizeactive, 0 -64"
        "$mainMod, H, resizeactive, 0 64"
        "$mainMod ALT, M,  layoutmsg, orientationleft"
        "$mainMod ALT, I, layoutmsg, orientationright"
        "$mainMod ALT, E,    layoutmsg, orientationtop"
        "$mainMod ALT, N,  layoutmsg, orientationbottom"
        "$mainMod ALT, space,  layoutmsg, orientationcenter"
        

        "$mainMod, mouse_up, layoutmsg, removemaster"
        "$mainMod, mouse_down, layoutmsg, addmaster"
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
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = ["${./wallpapers/rpnickson.jpg}" "${./wallpapers/atglobe.jpeg}" "${./wallpapers/atlandscape.jpg}"];
      wallpaper = ", ${./wallpapers/atglobe.jpeg}";
    };
  };
  services.hypridle = {
    enable = true;
    settings = {
      listener = [
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
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
      opacity: 0.95;
      border-radius: 8;
      background: #24273a;
      color: #cad3f5;
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
      border-radius: 6px 8px 8px 6px;
    }
    #custom-rofi {
      background: #f5bde6;
      color: #24273a;
      border-radius: 8px;
      border-color: #24273a;
      border: 4px solid;
      padding: 0 1em 0 0.5em;
      font-size: 30;
    }
    #workspaces button {
      color: #cad3f5;
    }
    #workspaces button.active, #taskbar button.active {
      background: #f5bde6;
      color: #24273a;
      border-radius: 8px;
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
          on-click = "killall rofi || rofi -show drun -show-icons";
        };
        "custom/vpn" = {
          format = "{icon}";
          tooltip-format = "{}";
          format-icons = ["" ""];
          exec = ''
            systemctl list-units openvpn-* --output json | jq --unbuffered --compact-output '{percentage: (if length > 0 then 100 else 0 end), text: (.[].unit // "none") | sub("^openvpn-";"") | sub(".service"; "")}'
          '';
          on-click = "pkexec systemctl stop openvpn-p2p.service";
          return-type = "json";
          interval = 15;
        };
        clock = {
          format = "{:%H.%M}";
          tooltip = true;
          tooltip-format = "{:%Y-%m-%d}";
          timezone = "America/Denver";
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
    themeFile = "Catppuccin-Macchiato";
    font = {
      package = pkgs.nerd-fonts.fira-code;
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
      name = "catppuccin-macchiato-pink-compact+rimless";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
    };
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "pink";
      };
      name = "Papirus-Dark";
    };
  };
  # programs.sm64ex.baserom = /home/vael/roms/n64/baserom.us.z64;
} 
