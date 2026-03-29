{ inputs, ... }:
{
  flake.nixosModules.docker =
    { config, pkgs, ... }:

    {
      virtualisation.docker.enable = true;
      users.extraGroups.docker.members = [ "espdesign" ];
    };
}
