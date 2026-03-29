{ self, inputs, ... }:
{

  flake.nixosModules.desktopConfiguration =
    { pkgs, lib, ... }:
    {
      # import any other modules from here
      imports = [
        self.nixosModules.desktopHardware
        self.nixosModules.niri
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # ...
    };

}
