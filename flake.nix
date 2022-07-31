{
  description = "my ENV.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-21.11-darwin";
    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    yabai = {
      url = "github:koekeishiya/yabai";
      flake = false;
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # rokka-nvim.url = "path:/Users/ttak0422/ghq/github.com/ttak0422/rokka-nvim";
    rokka-nvim.url = "github:ttak0422/rokka-nvim";

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    nix-doom-emacs.inputs.emacs-overlay.follows = "emacs-overlay";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, flake-utils, ... }:
    let
      inherit (nixpkgs.lib) attrValues optionalAttrs;
      inherit (darwin.lib) darwinSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      inherit (flake-utils.lib) eachDefaultSystem eachSystem allSystems;

      workUserName = "REPLACE";
      workUserEmail = "REPLACE";

      userName = "ttak0422";
      userEmail = "ttak0422@gmail.com";

      nixpkgsConfig = {
        config = {
          allowUnfree = true;
          # allowBroken = true;
        };
        overlays = attrValues self.overlays
          ++ [ inputs.neovim-nightly-overlay.overlay ] ++ (with inputs;
            [
              (final: prev: {
                # https://github.com/shaunsingh/nix-darwin-dotfiles/blob/2de71812cf0d1b75397e2f3ad90749ee26232ce6/flake.nix#L102-L115
                yabai = let
                  version = "4.0.1";
                  buildSymlinks = prev.runCommand "build-symlinks" { } ''
                    mkdir -p $out/bin
                    ln -s /usr/bin/xcrun /usr/bin/xcodebuild /usr/bin/tiffutil /usr/bin/qlmanage $out/bin
                  '';
                in prev.yabai.overrideAttrs (old: {
                  inherit version;
                  nativeBuildInputs = [ buildSymlinks ];
                  src = inputs.yabai;
                  buildInputs = with prev.darwin.apple_sdk.frameworks; [
                    Carbon
                    Cocoa
                    ScriptingBridge
                    prev.xxd
                    SkyLight
                  ];
                });
              })
            ]);
      };

      mkHomeManagerConfig =
        args@{ userHmConfig ? ./modules/home-manager/tiny.nix, ... }: {
          imports = [
            userHmConfig
            inputs.rokka-nvim.hmModule
            inputs.nix-doom-emacs.hmModule
          ];
          home = { stateVersion = "22.11"; };
        };

      mkDarwinModules = args@{ user, host
        , userConfig ? ./modules/darwin/tiny.nix
        , userHomebrewConfig ? ./modules/homebrew/tiny.nix, ... }: [
          userConfig
          userHomebrewConfig
          home-manager.darwinModules.home-manager
          {
            nixpkgs = nixpkgsConfig;
            users.users.${user}.home = "/Users/${user}";
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.${user} = mkHomeManagerConfig args;
              # https://github.com/nix-community/home-manager/issues/1698
              extraSpecialArgs = args.specialArgs;
            };
          }
        ];

      mkPersonalDarwinModules = { userName, host, specialArgs, ... }:
        mkDarwinModules {
          inherit host specialArgs;
          user = userName;
          userConfig = ./modules/darwin/personal.nix;
          userHmConfig = ./modules/home-manager/personal.nix;
          userHomebrewConfig = ./modules/homebrew/personal.nix;
        };
    in {
      checks = {
        x86_64-darwin = {
          ci = self.darwinConfigurations.ci.config.system.build.toplevel;
        };
      };

      overlays = {
        pkgs-unstable = final: prev: {
          pkgs-master = import inputs.nixpkgs {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };
        pkgs-stable = final: prev: {
          pkgs-stable = import inputs.nixpkgs-stable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };
      };

      darwinConfigurations = {
        # aarch64-darwin
        darwinM1 = let
          system = "aarch64-darwin";
          specialArgs = { inherit inputs userName userEmail; };
          modules = mkPersonalDarwinModules {
            inherit userName specialArgs;
            host = "mbp";
          } ++ [ ./modules/nix/prelude.nix ];
        in darwinSystem { inherit system modules specialArgs; };

        # x86_64-darwin
        darwinIntel = let
          system = "x86_64-darwin";
          specialArgs = { inherit inputs userName userEmail; };
          modules = mkPersonalDarwinModules {
            inherit userName specialArgs;
            host = "${userName}-intel";
          };
        in darwinSystem { inherit system specialArgs modules; };

        workDarwin = let
          system = "x86_64-darwin";
          specialArgs = {
            inherit inputs;
            userName = workUserName;
            userEmail = workUserEmail;
          };
          modules = mkDarwinModules {
            inherit userName specialArgs;
            host = "${workUserName}";
            user = workUserName;
            userConfig = ./modules/darwin/work.nix;
            userHmConfig = ./modules/home-manager/work.nix;
            userHomebrewConfig = ./modules/homebrew/work.nix;
          } ++ [ ./modules/nix/prelude.nix ];
        in darwinSystem { inherit system specialArgs modules; };

        # macos (x86_64)
        ci = let
          system = "x86_64-darwin";
          userName' = "runner";
          specialArgs = {
            inherit inputs userEmail;
            userName = userName';
          };
          modules = mkDarwinModules {
            inherit specialArgs;
            user = userName';
            host = "${userName}-intel";
            userConfig = ./modules/darwin/personal.nix;
            userHmConfig = ./modules/home-manager/personal.nix;
          };
        in darwinSystem { inherit system specialArgs modules; };
      };
    }
    # WIP
    // eachSystem [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ] (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [ nixfmt pre-commit ];
          shellHook = "";
        };
      });
}
