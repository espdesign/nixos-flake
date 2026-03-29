{ self, inputs, ... }:
{
  flake.nixosModules.baseFonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        fira-code
        font-manager
        font-awesome_5
        noto-fonts
        jetbrains-mono
      ];

    };
}
