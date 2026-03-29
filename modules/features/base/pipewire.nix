{ self, ... }:
{
  flake.nixosModules.pipewire =
    { pkgs, ... }:
    {
      # Enable sound with pipewire.
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;

        # Optional: If you want to use JACK applications
        # jack.enable = true;
      };

      # Optional: Add GUI tools for audio control
      environment.systemPackages = with pkgs; [
        easyeffects
      ];
    };
}
