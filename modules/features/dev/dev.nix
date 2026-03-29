{ inputs, ... }:
{
  flake.nixosModules.dev =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      customExtensions = [
        pkgs.vscode-extensions.jnoortheen.nix-ide
        pkgs.vscode-extensions.dbaeumer.vscode-eslint
        pkgs.vscode-extensions.esbenp.prettier-vscode
        pkgs.vscode-extensions.bradlc.vscode-tailwindcss

        # Use extensionFromVscodeMarketplace for cleaner argument handling
        (pkgs.vscode-utils.extensionFromVscodeMarketplace {
          name = "theme-monokai-pro-vscode";
          publisher = "monokai";
          version = "2.0.12";
          sha256 = "e/IjWP+GgA8dTJWV9nloFVuv68Bh5DiW1QcVXpUdS3Q=";
        })
      ];

      vscode-with-extensions = pkgs.vscode-with-extensions.override {
        vscodeExtensions = customExtensions;
      };

      userSettings = {
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

    in
    {
      environment.systemPackages = [
        vscode-with-extensions
        pkgs.nil

      ];

      environment.etc."vscode/settings.json".text = builtins.toJSON userSettings;

      system.activationScripts.vscodeSettings = {
        text = ''
          USER_HOME="/home/espdesign"
          VSCODE_USER_DIR="$USER_HOME/.config/Code/User"

          if [ -d "$USER_HOME" ]; then
            mkdir -p "$VSCODE_USER_DIR"
            ln -sfn /etc/vscode/settings.json "$VSCODE_USER_DIR/settings.json"
            chown -R espdesign:users "$USER_HOME/.config/Code"
          fi
        '';
      };
    };
}
