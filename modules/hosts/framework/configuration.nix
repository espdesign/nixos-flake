{ self, inputs, ... }:
{

  flake.nixosModules.frameworkConfiguration =
    { pkgs, lib, ... }:
    {
      # import any other modules from here
      imports = [
        self.nixosModules.frameworkHardware
        self.nixosModules.base

        self.nixosModules.gnome
      ];

      networking.hostName = "framework";

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      system.stateVersion = "24.05";

    };

}
