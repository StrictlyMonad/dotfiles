{ pkgs, config, ... }: {
  xsession = {
    enable = true;
    preferStatusNotifierItems = true;
    importedVariables = [ "GDK_PIXBUF_ICON_LOADER" ];
  };

  home.keyboard = null;
  home.emptyActivationPath = false;
  programs.home-manager.enable = true;

  programs.ssh = {
    forwardAgent = true;
  };

  # programs.zsh = {
  #   enable = true;
  # };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 8 * 60 * 60;
    maxCacheTtl = 8 * 60 * 60;
    enableSshSupport = true;
  };

  services.blueman-applet = {
    enable = false;
  };

  services.taffybar = {
    enable = true;
    package = pkgs.haskellPackages.imalison-taffybar;
  };

  services.notify-osd = {
    enable = true;
    package = pkgs.notify-osd-customizable;
  };
  # skippyxd

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  services.network-manager-applet.enable = true;

  services.udiskie = {
    enable = true;
    tray = "always";
  };

  services.status-notifier-watcher.enable = true;

  services.random-background = {
    enable = true;
    display = "center";
    interval = "1h";
    imageDirectory = "%h/Pictures/wallpaper/use";
  };

  services.xsettingsd.enable = true;

  services.volnoti.enable = true;

  services.git-sync = {
    enable = true;
    repositories = [
      {
        name = "config";
        path = "/home/imalison/config";
        uri = "git@github.com:IvanMalison/config.git";
      }
      {
        name = "org";
        path = "/home/imalison/org";
        uri = "git@github.com:IvanMalison/org.git";
      }
      {
        name = "password-store";
        path = "/home/imalison/.password-store";
        uri = "git@github.com:IvanMalison/.password-store.git";
      }
    ];
  };

  systemd.user.services.setxkbmap = {
    Unit = {
      Description = "Set up keyboard in X";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };

    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "/usr/bin/env load_xkb_map";
    };
  };


  systemd.user.services.picom = {
    Unit = {
      Description = "Picom X11 compositor";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };

    Service = {
      ExecStart = "${pkgs.picom}/bin/picom --experimental-backends";
      Restart = "always";
      RestartSec = 3;
    };
  };
}
