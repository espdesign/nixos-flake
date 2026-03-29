{ self, inputs, ... }:
{

  flake.nixosModules.frameworkConfiguration =
    { pkgs, lib, ... }:
    {
      # import any other modules from here
      imports = [
        self.nixosModules.frameworkHardware
        self.nixosModules.nix
        self.nixosModules.gnome
        self.nixosModules.userConfiguration
        self.nixosModules.ghostty
      ];

      networking.hostName = "framework";

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      system.stateVersion = "24.05";

    };

}
