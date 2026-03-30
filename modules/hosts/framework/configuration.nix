{ self, inputs, ... }:
{

  flake.nixosModules.frameworkConfiguration =
    { pkgs, lib, ... }:
    {
      # import any other modules from here
      imports = [
        self.nixosModules.frameworkHardware
        self.nixosModules.default
        self.nixosModules.pipewire
        self.nixosModules.syncthing

        self.nixosModules.apps
        self.nixosModules.code
        self.nixosModules.zsh
        self.nixosModules.user
        self.nixosModules.nix
        self.nixosModules.fonts
        self.nixosModules.gnome
      ];

      networking.hostName = "framework";

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      system.stateVersion = "24.05";

    };

}
