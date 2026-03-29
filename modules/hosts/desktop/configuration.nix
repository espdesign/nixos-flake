{ self, inputs, ... }:
{

  flake.nixosModules.desktopConfiguration =
    { pkgs, lib, ... }:
    {
      # import any other modules from here
      imports = [
        self.nixosModules.desktopHardware
        #specific to gaming machine
        self.nixosModules.nvidia
        self.nixosModules.gaming

        self.nixosModules.apps
        self.nixosModules.dev
        self.nixosModules.syncthing
        self.nixosModules.zsh
        self.nixosModules.printing
        self.nixosModules.pipewire
        self.nixosModules.default
        self.nixosModules.user
        self.nixosModules.nix
        self.nixosModules.fonts
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
