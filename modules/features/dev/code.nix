{ self, inputs, ... }:

{
  # 1. Define the NixOS Module
  flake.nixosModules.code =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.modules.dev.vscode.enable = lib.mkEnableOption "VS Code development environment";

      config = lib.mkIf config.modules.dev.vscode.enable {
        environment.systemPackages = [
          # Reference the package defined in perSystem below
          self.packages.${pkgs.stdenv.hostPlatform.system}.vscode-dev
          pkgs.nil
        ];

        # Global settings file in /etc
        environment.etc."vscode/settings.json".text = builtins.toJSON {
          "editor.fontFamily" = "'JetBrains Mono', 'monospace', monospace";
          "editor.fontLigatures" = false;
          "editor.fontSize" = 14;
          "editor.rulers" = [
            80
            120
          ];
          "workbench.colorTheme" = "Monokai Pro";
          "workbench.iconTheme" = "Monokai Pro Icons";
          "editor.formatOnSave" = true;
          "editor.minimap.enabled" = false;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
        };

        # Symlink script for the user
        system.activationScripts.vscodeSettings = {
          text = ''
            USER_HOME="/home/espdesign"
            VSCODE_USER_DIR="$USER_HOME/.config/Code/User"

            if [ -d "$USER_HOME" ]; then
              mkdir -p "$VSCODE_USER_DIR"
              # ln -sfn ensures the symlink is updated/overwritten if it exists
              ln -sfn /etc/vscode/settings.json "$VSCODE_USER_DIR/settings.json"
              chown -R espdesign:users "$USER_HOME/.config/Code"
            fi
          '';
        };
      };
    };

  # 2. Define the Package per architecture
  perSystem =
    { pkgs, ... }:
    {
      packages.vscode-dev = pkgs.vscode-with-extensions.override {
        vscodeExtensions = [
          pkgs.vscode-extensions.jnoortheen.nix-ide
          pkgs.vscode-extensions.dbaeumer.vscode-eslint
          pkgs.vscode-extensions.esbenp.prettier-vscode
          pkgs.vscode-extensions.bradlc.vscode-tailwindcss

          (pkgs.vscode-utils.extensionFromVscodeMarketplace {
            name = "theme-monokai-pro-vscode";
            publisher = "monokai";
            version = "2.0.12";
            sha256 = "e/IjWP+GgA8dTJWV9nloFVuv68Bh5DiW1QcVXpUdS3Q=";
          })
        ];
      };
    };
}
