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
    size = 16;
    x11.enable = true;
    gtk.enable = true;
  };
  fonts.fontconfig.enable = true;
  xdg.portal = {
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  };
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    ardour
    firefox
    chromium
    vscodium
    godot_4
    steamcmd
    discord-canary
    nautilus
    qview
    deluge
    wgnord
    krita
    hyfetch
    neovide
    audacity
    bitwig-studio
    blender
    vlc
    ghc
    cardinal
    gparted
    supercollider-with-plugins
    pavucontrol
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    stable.openscad-unstable
    helvum
    ffmpeg
    gnome-software
    organicmaps
    killall
    pstree
    spotify
    feh
    filezilla
    protontricks
    prismlauncher
    kdePackages.kpat
    stable.sauerbraten
    gimp
    inkscape
    glfw
    r2modman
    waypipe
    wayvnc
    osslsigncode
    stable.bambu-studio
    orca-slicer
    btop
    ncdu
    file
    brightnessctl
    hyprcursor
    hyprpaper
    hyprpolkitagent
    thunderbird
    dosbox-x
    kdePackages.kdenlive
    # trenchbroom
    lutris
    sweethome3d.application
    alsa-scarlett-gui
    simple-scan
    gtklp
    vinegar
    pixelorama
    # stable.freecad
    stable.yabridge
    stable.yabridgectl
    stable.winetricks
    stable.wineWowPackages.waylandFull
    stable.corefonts
    grim
    slurp
    wl-clipboard
    libsForQt5.qt5ct
    networkmanagerapplet
    valgrind
    jq
    kdePackages.qtstyleplugin-kvantum
    (catppuccin-kvantum.override {
      accent = "pink";
      variant = "macchiato";
    })
    hyprpolkitagent
    # language servers and such
    nodePackages.nodejs
    nodePackages.coc-clangd
    clang-tools
    nil
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
  programs.nushell = {
    enable = true;
    configFile = {
      text = ''
      $env.config.show_banner = false
      def H [] {Hyprland}
      '';
    };
  };
  programs.bash = {
    bashrcExtra = '''';
    enable = true;
  };


  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    font = "FiraCode Nerd Font 18";
    theme = ./rofi/themes/catppuccin-macchiato.rasi;
    extraConfig = {
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 󰕰  Window";
      display-Network = " 󰤨  Network";
      sidebar-mode = true;
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
        "uwsm app -- waybar"
        "uwsm app -- dunst"
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
        resolve_binds_by_sym = true;
        kb_layout = "us";
        # follow_mouse = 1;
        # mouse_refocus = 1;
        accel_profile = "flat";
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0.5;
      };
      "input:touchpad" = {
        disable_while_typing = false;
      };
      general = {
        gaps_in = 2;
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
        inactive_opacity = 0.85;
        shadow = {
          enabled = true;
          range = 3;
          render_power = 3;
          color = "rgba(1a1a1aff)";
        };
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
        slave_count_for_center_master = 1;
        # always_center_master = true;
      };
      gesture = [
        "4, horizontal, workspace"
        "3, vertical, move"
        "3, horizontal, resize"
        "4, up, fullscreen"
        "4, down, fullscreen, minimize"
      ];
      device = [{
        name = "hid-256c:006d-pen";
        output = "HDMI-A-2";
      }];
      windowrulev2 = [
        "stayfocused, title:^()$,class:^(steam)$"
        "minsize 1 1, title:^()$,class:^(steam)$"
        # "stayfocused, class:^(OrcaSlicer)$,title:^()$"
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
      ];
      layerrule = [
      ];
      bindr = [
        "$mainMod, Super_L, exec, killall rofi || uwsm app -- rofi -show drun -show-icons"
      ];
      bind =
        [
          "$mainMod, C, killactive,"
          "$mainMod, Escape, exit,"
          "$mainMod, A, exec, uwsm app -- nautilus"
          "$mainMod, F, exec, uwsm app -- firefox"
          "$mainMod, V, togglefloating,"
          "$mainMod, Space, exec, uwsm app -- kitty"
          "$mainMod, P, pseudo,"
          "$mainMod, R, togglesplit,"
          "$mainMod, tab, exec, pkill waybar || uwsm app -- waybar"
          ", Print, exec, uwsm app -- grim -g \"$(slurp -d)\" - | wl-copy"
          "SHIFT, Print, exec, uwsm app -- grim - | wl-copy"

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
          "$mainMod, H, resizeactive, 0 64"
          "$mainMod ALT, M,  layoutmsg, orientationleft"
          "$mainMod ALT, I, layoutmsg, orientationright"
          "$mainMod ALT, E,    layoutmsg, orientationtop"
          "$mainMod ALT, N,  layoutmsg, orientationbottom"
          "$mainMod ALT, space,  layoutmsg, orientationcenter"

          "$mainMod, mouse_up, layoutmsg, removemaster"
          "$mainMod, mouse_down, layoutmsg, addmaster"
        ]
        ++ builtins.concatLists (
          builtins.genList (
            x:
            let
              ws = if x == 0 then 10 else x;
              key = toString x;
            in
            [
              "$mainMod, ${key}, workspace, ${toString ws}"
              "$mainMod SHIFT, ${key}, movetoworkspace, ${toString ws}"
              "$mainMod CTRL, ${key}, workspace, ${toString (ws + 10)}"
              "$mainMod CTRL SHIFT, ${key}, movetoworkspace, ${toString(ws + 10)}"
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
  services.dunst = {
    enable = true;
    settings = builtins.fromTOML ''
    [global]
    font = "FiraCode Nerd Font 14"
    frame_color = "#f5bde6"
    separator_color = "frame"
    highlight = "#f5bde6"
    corner_radius = 8

    [urgency_low]
    background = "#24273a"
    foreground = "#cad3f5"

    [urgency_normal]
    background = "#24273a"
    foreground = "#cad3f5"

    [urgency_critical]
    background = "#24273a"
    foreground = "#cad3f5"
    frame_color = "#f5a97f"
    '';
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [
        "${./wallpapers/rpnickson.jpg}"
        "${./wallpapers/atglobe.jpeg}"
        "${./wallpapers/atlandscape.jpg}"
        "${./wallpapers/attreehouse.jpg}"
      ];
      wallpaper = ", ${./wallpapers/attreehouse.jpg}";
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
        opacity: 0.85;
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
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        margin = "4px";
        height = 48;
        spacing = 2;
        modules-left = [
          "custom/rofi"
          "hyprland/workspaces"
          "wlr/taskbar"
        ];
        modules-center = [
          "hyprland/window"
          "mpris"
        ];
        modules-right = [
          "bluetooth"
          "network"
          "custom/vpn"
          "wireplumber"
          "battery"
          "backlight"
          "clock"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
        };
        "wlr/taskbar" = {
          on-click = "activate";
          icon-size = 18;
        };
        "custom/rofi" = {
          format = "";
          on-click = "pkill rofi || rofi -show drun -show-icons";
        };
        "custom/vpn" = {
          format = "{icon}";
          tooltip-format = "{}";
          format-icons = [
            ""
            ""
          ];
          exec = ''
            systemctl is-active --quiet openvpn-p2p.service && echo '{"percentage": 100}' || echo '{"percentage": 0}';
          '';
          on-click = "systemctl is-active --quiet openvpn-p2p.service && systemctl stop openvpn-p2p.service || systemctl start openvpn-p2p.service";
          return-type = "json";
          interval = 5;
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
          format-icons = [
            ""
            ""
            ""
          ];
          on-click = "pavucontrol";
          on-click-right = "qpwgraph";
        };
        network = {
          on-click = "nm-connection-editor";
          format-icons = [
            "󰤯"
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤨"
          ];
          tooltip-format-wifi = "{essid}";
          format-wifi = "{icon}";
          format-disconnected = "󰤮";
          format-ethernet = "󰛳";
          format-linked = "󰲊";
        };
        bluetooth = {
          format-connected = "󰂰";
          format-on = "󰂯";
          format-off = "󰂲";
          on-click = "blueman-manager";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-device-enumerate-connected = "{device_alias}";
        };
        battery = {
          format = " {icon}";
          tooltip-format = "{capacity}%";
          format-charging = "{icon}󱐋";
          format-icons = [
            "󰂃"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󱟢"
          ];
        };
        backlight = {
          format = "󰍹";
          tooltip-format = "{percent}%";
          format-icons = [
            "󰃜"
            "󰃛"
            "󰃚"
            "󰃞"
            "󰃟"
            "󰃝"
            "󰃠"
          ];
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
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      nvim-dap
      catppuccin-nvim
      telescope-nvim
      telescope-coc-nvim
      coc-nvim
      coc-clangd
    ];
    extraLuaConfig = ''
    -- paths to check for project.godot file
    local paths_to_check = {'/', '/../'}
    local is_godot_project = false
    local godot_project_path = ""
    local cwd = vim.fn.getcwd()
    local telescope = require('telescope.builtin')

    require("catppuccin").setup({
        flavour = "macchiato"
    })

    vim.keymap.set('n', '<C-p>', telescope.find_files, {})
    vim.cmd.colorscheme "catppuccin"
    vim.opt.wrap = false        
    vim.opt.number = true
    vim.opt.expandtab = true
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2

    -- define functions only for Godot projects
    if is_godot_project then
        -- write breakpoint to new line
        vim.api.nvim_create_user_command('GodotBreakpoint', function()
            vim.cmd('normal! obreakpoint' )
            vim.cmd('write' )
        end, {})
        vim.keymap.set('n', '<leader>b', ':GodotBreakpoint<CR>')

        -- delete all breakpoints in current file
        vim.api.nvim_create_user_command('GodotDeleteBreakpoints', function()
            vim.cmd('g/breakpoint/d')
        end, {})
        vim.keymap.set('n', '<leader>BD', ':GodotDeleteBreakpoints<CR>')

        -- search all breakpoints in project
        vim.api.nvim_create_user_command('GodotFindBreakpoints', function()
            vim.cmd(':grep breakpoint | copen')
        end, {})
        vim.keymap.set('n', '<leader>BF', ':GodotFindBreakpoints<CR>')

        -- append "# TRANSLATORS: " to current line
        vim.api.nvim_create_user_command('GodotTranslators', function(opts)
            vim.cmd('normal! A # TRANSLATORS: ')
        end, {})
    end


    -- iterate over paths and check
    for key, value in pairs(paths_to_check) do
        if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
            is_godot_project = true
            godot_project_path = cwd .. value
            break
        end
    end

    -- check if server is already running in godot project path
    -- local pipe_path = "/tmp/godot-nvim-" .. vim.fn.fnamemodify(godot_project_path, ':h:t') .. "-server.pipe"
    local pipe_path = godot_project_path .. "server.pipe"
    local is_server_running = vim.uv.fs_stat(pipe_path)
    
    -- start server, if not already running
    if is_godot_project and not is_server_running then
        vim.fn.serverstart(pipe_path)
    end
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
    #iconTheme = {
    #  package = pkgs.catppuccin-papirus-folders.override {
    #    flavor = "macchiato";
    #    accent = "pink";
    #  };
    #  name = "Papirus-Dark";
    #};
  };
  # programs.sm64ex.baserom = /home/vael/roms/n64/baserom.us.z64;
}
