{ self, inputs, ... }:
{

  flake.nixosModules.frameworkConfiguration =
    { pkgs, lib, ... }:
    {
      # import any other modules from here
      imports = [
        self.nixosModules.frameworkHardware
        self.nixosModules.niri
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # ...
    };

}
