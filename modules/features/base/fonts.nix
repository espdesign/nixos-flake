{ inputs, ... }:
{
  flake.nixosModules.fonts =
    { pkgs, self, ... }:
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
