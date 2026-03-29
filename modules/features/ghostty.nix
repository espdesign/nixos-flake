{
  self,
  inputs,
  ...
}:
{
  flake.wrapperModules.ghostty =
    { self, inputs, ... }:
    {
      # This makes the ghostty package available via self.packages.${system}.myGhostty
      perSystem =
        {
          pkgs,
          lib,
          self',
          ...
        }:
        {
          packages.myGhostty = inputs.wrapper-modules.wrappers.ghostty.wrap {
            inherit pkgs; # Crucial for the wrapper to find the base package

            settings = {
              theme = "dark:Gruvbox Dark,light:Gruvbox Light";
              window-decoration = "auto";
              background-opacity = 0.95;
              background-blur = true;
            };
          };
        };

      # Optional: Define a NixOS module to easily enable your wrapped Ghostty
      flake.nixosModules.ghostty =
        { pkgs, ... }:
        {
          environment.systemPackages = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.myGhostty
          ];
        };
    };
}
