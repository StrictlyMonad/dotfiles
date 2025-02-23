{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bitwarden
    obsidian
    vlc
    obs-studio
    ffmpeg
  ];

  home-manager.users.kat = { pkgs, config, ... }: {
    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 8 * 60 * 60;
      maxCacheTtl = 8 * 60 * 60;
      enableSshSupport = true;
      pinentryFlavor = "qt";
    };

    services.kdeconnect = {
      enable = true;
      indicator = true;
    };

    services.git-sync = {
      enable = true;
      repositories = {
        obsidian = {
          path = config.home.homeDirectory + "/obsidian";
          uri = "git@github.com:katandtonic/obsidian.git";
          interval = 60;
        };
      };
    };

    home.stateVersion = "23.11";
  };
}
