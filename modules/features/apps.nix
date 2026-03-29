{ self, inputs, ... }:
{
  flake.nixosModules.apps =
    {
      pkgs,
      inputs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        opencode
        gemini-cli
        devenv
        # Remote Desktop
        rustdesk-flutter

        # Productivity
        obsidian
        libreoffice
        typst
        stirling-pdf

        # Communication
        vesktop
        slack
        signal-desktop

        # Media
        spotify
        mpv
        bottles
        qbittorrent

        # GNOME Utilities
        dconf-editor
        gnome-shell-extensions
      ];
    };
}
