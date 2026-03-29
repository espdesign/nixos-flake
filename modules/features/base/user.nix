{ self, inputs, ... }:
{
  flake.nixosModules.baseUser =
    { pkgs, ... }:
    {
      users.users.espdesign = {
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        # shell = pkgs.zsh;
        #Same as your wifi bozo
        initialHashedPassword = "$y$j9T$zF7JiEIMHzI129enypz0B/$DZy1PvKBR.Pm2Hq7JBNbOesM4AwzsuVdK0eOcS5dVw4";
      };

    };
}
