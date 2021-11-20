{
  description = "my ENV.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, flake-utils, ... }:
    let
      inherit (nixpkgs.lib) attrValues optionalAttrs;
      inherit (darwin.lib) darwinSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      inherit (flake-utils.lib) eachDefaultSystem eachSystem allSystems;

      nixpkgsConfig = {
        config = { allowUnfree = true; };
        overlays = attrValues self.overlays;
      };

      mkHomeManagerConfig =
        args@{ user, userConfig ? "./modules/home-manager/tiny.nix", ... }: {
          imports = [ ];
        };
      mkDarwinModules = args@{ user, host, ... }: [
        ./modules/darwin/prelude.nix
        home-manager.darwinModules.home-manager
        ({ config, pkgs, lib, ... }: {
          nixpkgs = nixpkgsConfig;
          users.users.${user}.home = "/Users/${user}";
          home-manager = {
            useGlobalPkgs = true;
            users.${user} = mkHomeManagerConfig args;
          };
        })
      ];

    in {
      overlays = {
        pkgs-master = final: prev: {
          pkgs-master = import inputs.nixpkgs {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };
      };

      darwinConfigurations = {
        darwinM1 = darwinSystem {
          system = "aarch64-darwin";
          inputs = inputs;
          modules = mkDarwinModules {
            user = "ttak0422";
            host = "mbp";
          } ++ [ ./modules/nix/prelude.nix ];
        };
        darwinIntelCI = darwinSystem {
          system = "x86_64-darwin";
          modules = mkDarwinModules {
            user = "ci";
            host = "ci";
          };
        };
      };
    } // eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.nixfmt ];
          shellHook = "";
        };
      });
}
