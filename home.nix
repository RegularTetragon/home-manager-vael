{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage./home/vael
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
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];

  };
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    ardour
    firefox
    chromium
    vscodium
    unstable.godot
    steamcmd
    unstable.discord
    nautilus
    qview
    deluge
    wgnord
    krita
    hyfetch
    neovide
    audacity
    bitwig-studio
    xwayland-satellite
    rnnoise-plugin
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
    qpwgraph
    ffmpeg
    gnome-software
    organicmaps
    killall
    pstree
    spotify
    swaybg
    feh
    filezilla
    protontricks
    prismlauncher
    kdePackages.kpat
    stable.sauerbraten
    gimp
    bolt-launcher
    runelite
    inkscape
    glfw
    r2modman
    waypipe
    wayvnc
    osslsigncode
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
  programs.git = {
    signing.format = "openpgp";
    enable = true;
    lfs.enable = true;
  };
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
    bashrcExtra = "";
    enable = true;
  };
  programs.fuzzel = {
    enable = true;
    settings = { };
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

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
    settings = {
      prefer-no-csd = true;
      overview = {
        backdrop-color = "#181926";
      };
      xwayland-satellite = {
        enable = true;
        path = lib.getExe pkgs.xwayland-satellite-unstable;
      };

      spawn-at-startup = [
        { argv = [ "waybar" ]; }
        {
          argv = [
            "swaybg"
            "--image"
            ".config/home-manager/wallpapers/attreehouse.jpg"
          ];
        }
        { argv = [ "dunst" ]; }
      ];
      window-rules = [
        {
          geometry-corner-radius = {
            bottom-left = 8.0;
            bottom-right = 8.0;
            top-left = 8.0;
            top-right = 8.0;
          };
          clip-to-geometry = true;
        }
      ];
      input = {
        touchpad = {
          natural-scroll = false;
        };
      };
      layout = {
        gaps = 4;
        focus-ring = {
          width = 2;
          active = {
            color = "rgb(245, 189, 230)";
          };
        };
      };
      binds = lib.attrsets.mergeAttrsList (
        [
          {
            "Mod+Space".action.spawn = [
              "rofi"
              "-show"
              "drun"
              "-show-icons"
            ];
            "Mod+Comma".action.consume-window-into-column = [ ];
            "Mod+Period".action.expel-window-from-column = [ ];
            "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
            "Mod+BracketRight".action.consume-or-expel-window-right = [ ];
            "Mod+Return".action.spawn = "kitty";
            "Mod+Q".action.close-window = [ ];
            "Mod+Escape".action.quit = [ ];
            "Mod+Shift+E".action.set-window-height = "+5%";
            "Mod+Shift+I".action.set-window-height = "-5%";
            "Mod+Shift+O".action.set-column-width = "+5%";
            "Mod+Shift+N".action.set-column-width = "-5%";
            "Mod+E".action.focus-window-up = [ ];
            "Mod+I".action.focus-window-down = [ ];
            "Mod+N".action.focus-column-left = [ ];
            "Mod+O".action.focus-column-right = [ ];
            "Mod+Ctrl+E".action.move-window-up = [ ];
            "Mod+Ctrl+I".action.move-window-down = [ ];
            "Mod+Ctrl+N".action.move-column-left = [ ];
            "Mod+Ctrl+O".action.move-column-right = [ ];
            "Mod+Home".action.focus-column-first = [ ];
            "Mod+End".action.focus-column-last = [ ];
            "Mod+F".action.maximize-column = [ ];
            "Mod+Shift+F".action.fullscreen-window = [ ];
            "Print".action.screenshot = {
              show-pointer = false;
            };
            "Ctrl+Print".action.screenshot-screen = {
              show-pointer = false;
            };
            "Shift+Print".action.screenshot-window = { };
            "XF86AudioMute".action.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SINK@"
              "toggle"
            ];
            "XF86AudioRaiseVolume".action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.1+"
            ];
            "XF86AudioLowerVolume".action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.1-"
            ];
          }
        ]
        ++ builtins.genList (
          x:
          let
            ws = if x == 0 then 10 else x;
            key = toString x;
          in
          {
            "Mod+${key}".action."focus-workspace" = ws;
            "Mod+Ctrl+${key}".action."move-window-to-workspace" = ws;
          }
        ) 10
      );
    };
  };
  services.udiskie = {
    enable = true;
  };
  services.easyeffects = {
    enable = true;
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
    # see flake
    settings = {
      ipc = "on";
      splash = false;
      preload = [
        "${./wallpapers/rpnickson.jpg}"
        "${./wallpapers/atglobe.jpeg}"
        "${./wallpapers/atlandscape.jpg}"
        "${./wallpapers/attreehouse.jpg}"
      ];
      wallpaper = [
        {
          monitor = "";
          path = "${./wallpapers/attreehouse.jpg}";
        }
      ];
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
        opacity: 1.0;
        border-radius: 8 8 0 0;
        background: alpha(#24273a, 0.9);
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
        margin = "0px 4px 0px 4px";
        height = 48;
        spacing = 2;
        modules-left = [
          "custom/rofi"
          "niri/workspaces"
          "wlr/taskbar"
        ];
        modules-center = [
          "niri/window"
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
    ];
    withRuby = true;
    withPython3 = true;
    initLua = ''
      vim.cmd.colorscheme "catppuccin-macchiato"
      -- paths to check for project.godot file
      local paths_to_check = {'/', '/../'}
      local is_godot_project = false
      local godot_project_path = ""
      local cwd = vim.fn.getcwd()
      local telescope = require('telescope.builtin')
      local dap = require('dap')

      require("catppuccin").setup({
          flavour = "macchiato"
      })
      vim.g.mapleader = ","
      vim.keymap.set('n', '<C-p>', telescope.find_files, {})
      vim.cmd.colorscheme "catppuccin"
      vim.opt.wrap = false        
      vim.opt.number = true
      vim.opt.expandtab = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2

      -- iterate over paths and check
      for key, value in pairs(paths_to_check) do
          if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
              is_godot_project = true
              godot_project_path = cwd .. value
              break
          end
      end
      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "Launch Scene",
          project = "''${workspaceFolder}"
        }
      }

      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006
      }
      vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
      vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
      vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
      vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
      vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
      vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
      vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
      vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
      vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
      vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
        require('dap.ui.widgets').hover()
      end)
      vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
        require('dap.ui.widgets').preview()
      end)
      vim.keymap.set('n', '<Leader>df', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
      end)
      vim.keymap.set('n', '<Leader>ds', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
      end)


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
    gtk4.theme = config.gtk.theme;
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
