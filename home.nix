{ config, pkgs,  ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vael";
  home.homeDirectory = "/home/vael";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.macchiatoPink;
    name = "Catppuccin-Macchiato-Pink-Cursors";
    x11.enable = true;
    gtk.enable = true;
  };
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
      nerdfonts
      fira-code-nerdfont
      ardour
      firefox
      vscodium
      godot_4
      steamcmd
      discord
      dolphin
      deluge
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
      cura
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
      btop
      brightnessctl
      hyprcursor
      stable.trenchbroom
      stable.yabridge stable.yabridgectl stable.winetricks stable.wineWowPackages.stable stable.corefonts
      rofi-wayland swww waypaper grim slurp wl-clipboard dunst qt5ct networkmanagerapplet
      (retroarch.override {
        cores = with libretro; [
          mgba
          mupen64plus
          dosbox
          dolphin
        ];
      })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/vael/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.sm64ex = {
#    enable = true;
  };
  programs.waybar = {
    enable = true;
    style = ''
    * {
      font-family: "FiraCode Nerd Font";
      font-size: 18;
    }
    window#waybar {
      opacity: 0.8;
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
        output = [ "eDP-1" ];
        modules-left = [ "custom/rofi" "hyprland/workspaces" "wlr/taskbar"];
        modules-center = [ "hyprland/window" "mpris" ];
        modules-right = [  "bluetooth" "network" "wireplumber" "battery" "backlight" "clock"  ];
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
        clock = {
          format = "{:%H.%M}";
          tooltip = true;
          tooltip-format = "{:%Y-%m-%d}";
          timezone = "America/New_York";
        };
        wireplumber = {
          format = "{volume}% {icon}";
          format-muted = "󰝟";
          format-icons = ["" "" ""];
          on-click = "pavucontrol";
          on-click-right = "qpwgraph";
        };
        network = {
          on-click = "nm-connection-editor";
          format-wifi = "{essid} {signalStrength}% ";
          format-disconnected = "no wifi";
        };
        bluetooth = {
          on-click = "blueman-manager";
          tooltip-format-connected = "{device_enumerate";
          tooltip-device-enumerate-connected = "{device_alias}";
        };
        battery = {
          format = " {capacity}% {icon}";
          format-charging = "{capacity}+% {icon}";
          format-icons = ["" "" "" "" ""];
        };
        backlight = {
          format = "{percent}% {icon}";
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
      telescope-nvim
    ];
    extraConfig = ''
      set nowrap
      set number
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set softtabstop=2
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
