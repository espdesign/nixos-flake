{ self, inputs, ... }:
{
  flake.nixosModules.gnome =
    { pkgs, ... }:
    {

      # Enable the GNOME Desktop Environment.
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;

      environment.etc."backgrounds/wallpaper.jpg".source = ./base/wallpaper.jpg;

      # To disable installing GNOME's suite of applications
      # and only be left with GNOME shell.
      services.gnome.core-apps.enable = false;
      services.gnome.core-developer-tools.enable = false;
      services.gnome.games.enable = false;
      environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-user-docs
      ];

      # Add GNOME specific system packages (like Tweaks)
      environment.systemPackages = with pkgs; [
        gnomeExtensions.appindicator
      ];

      programs.dconf.profiles.user.databases = [
        {
          lockAll = true; # prevents overriding
          settings = {
            "org/gnome/shell" = {
              disable-user-extensions = false;
              # Enable the app indicator extension (tray icons)
              enabled-extensions = [ "appindicatorsupport@rgcjonas.gmail.com" ];
              favorite-apps = [
                "org.gnome.Nautilus.desktop"
                "firefox.desktop"
                "com.mitchellh.ghostty.desktop"
              ];
            };

            "org/gnome/desktop/interface" = {
              show-battery-percentage = true;
              clock-format = "12h";
              color-scheme = "prefer-dark";
            };

            # Set desktop background for dark and light mode
            "org/gnome/desktop/background" = {
              picture-uri = "file:///etc/backgrounds/wallpaper.jpg";
              picture-uri-dark = "file:///etc/backgrounds/wallpaper.jpg";
            };
          };
        }
      ];
    };
}
