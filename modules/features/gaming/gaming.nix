{ self, ... }:
{
  flake.nixosModules.gaming =
    {
      pkgs,
      lib,
      ...
    }:
    {
      hardware.graphics.enable = lib.mkDefault true;
      # 1. Enable Steam
      programs.steam = {
        enable = true;

        # Open ports in the firewall for Steam Remote Play
        remotePlay.openFirewall = true;

        # Open ports for Source Dedicated Server
        dedicatedServer.openFirewall = true;

        # Open ports for local network game transfers (copying games from PC to Deck/Laptop)
        localNetworkGameTransfers.openFirewall = true;
      };

      # 2. Critical for Gaming: Enable 32-bit libraries
      # Steam contains 32-bit binaries, so this is mandatory.
      #hardware.graphics.enable32Bit = true;

      # 3. GameMode (Optimization tool)
      # Allows games to request a set of optimizations (CPU governor, etc.)
      programs.gamemode.enable = true; # https://nixos.wiki/wiki/Gamemode

      # 4. Useful packages for gaming
      #environment.systemPackages = with pkgs; [
      #protonup-qt # GUI tool to install Proton-GE (Glorious Eggroll)
      #mangohud # FPS overlay
      # ];
    };
}
