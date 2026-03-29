{ self, inputs, ... }:
{

  flake.nixosModules.desktopConfiguration =
    { pkgs, lib, ... }:
    {
      # import any other modules from here
      imports = [
        self.nixosModules.desktopHardware
        self.nixosModules.base

        self.nixosModules.gnome
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      networking.hostName = "desktop";

      # Bootloader specific to this machine (assuming systemd-boot)
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      system.stateVersion = "24.05";
      # ...
    };

}
