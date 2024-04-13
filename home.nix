{ config, pkgs, ... }:

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
      stable.trenchbroom
      stable.yabridge stable.yabridgectl stable.winetricks stable.wineWowPackages.stable stable.corefonts
      rofi-wayland swww waypaper grim slurp wl-clipboard dunst qt5ct
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
    settings =  {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "DP-1"
        ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" "mpris" ];
        modules-right = [ "bluetooth" "wireplumber" "clock" "wlr/taskbar" ];
        "hyprland/workspaces" = {
          format = "{icon}";
        };
        wireplumber = {
          on-click = "pavucontrol";
          on-click-right = "qpwgraph";
        };
        bluetooth = {
          on-click = "blueman-manager";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-device-enumerate-connected = "{device_alias} ";
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
