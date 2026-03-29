{ inputs, ... }:
{
  flake.nixosModules.zsh =
    { pkgs, ... }:
    {

      # 1. System-wide Packages
      users.users.espdesign.shell = pkgs.zsh;

      # 2. Configure Ghostty globally
      # This writes to /etc/xdg/ghostty/config, which Ghostty reads
      # as a system-wide default.
      environment.etc."xdg/ghostty/config".text = ''
        theme = dark:Gruvbox Dark,light:Gruvbox Light
        window-decoration = auto
        background-opacity = 0.95
        background-blur = true
      '';

      environment.systemPackages = with pkgs; [
        # Tools required for your aliases and shell flow
        neovim
        bat
        ripgrep
        eza
        ghostty
        fzf
        zoxide
        starship
        direnv
        nix-direnv
      ];

      # 2. ZSH Configuration
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
          # Utils
          vim = "nvim";
          c = "clear";

          # Modern Replacements
          cat = "bat";
          grep = "rg";
          ls = "eza --icons";
          ll = "eza -l --icons --git -a";
          lt = "eza --tree --level=2 --icons";

          # Nix Shortcuts
          nrb = "sudo nixos-rebuild build --flake .";
          nrs = "sudo nixos-rebuild switch --flake .";
          nfc = "nix flake check";
        };

        # Replacing initContent with interactiveShellInit for global use
        promptInit = ''

          # Point Starship to the global config you created
          export STARSHIP_CONFIG=/etc/xdg/starship.toml

          # Initialize Starship
          eval "$(starship init zsh)"
        '';
        interactiveShellInit = ''
          export NIX_PATH=nixpkgs=channel:nixos-unstable
          export NIX_LOG=info
          export TERMINAL=ghostty
          export EDITOR=nvim


          # Initialize Zoxide (replaces cd)
          eval "$(zoxide init zsh --cmd cd)"

          # Initialize FZF
          source <(fzf --zsh)
        '';
      };

      # 3. Direnv Configuration
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      # 4. Global Environment Variables (replaces bat.config)
      environment.variables = {
        BAT_THEME = "TwoDark";
      };

      # 5. Starship Configuration
      # Vanilla NixOS doesn't have a direct 'settings' attribute for starship like HM.
      # We provide the config file path or use the default.
      environment.etc."xdg/starship.toml".text = ''
        add_newline = true
        [aws]
        disabled = true
        [gcloud]
        disabled = true
        [line_break]
        disabled = true
      '';

    };
}
