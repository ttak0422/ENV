{
  description = "my ENV.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-21.05-darwin";
    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, flake-utils, ... }:
    let
      inherit (nixpkgs.lib) attrValues optionalAttrs;
      inherit (darwin.lib) darwinSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      inherit (flake-utils.lib) eachDefaultSystem eachSystem allSystems;

      nixpkgsConfig = {
        config = { allowUnfree = true; };
        overlays = attrValues self.overlays
          ++ [ inputs.neovim-nightly-overlay.overlay ];
      };

      mkHomeManagerConfig =
        args@{ userHmConfig ? ./modules/home-manager/tiny.nix, ... }: {
          imports = [ userHmConfig ];
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
              extraSpecialArgs = args.specialArgs;
            };
          }
        ];

    in {
      overlays = {
        pkgs-master = final: prev: {
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
        darwinM1 = let
          system = "aarch64-darwin";
          # https://github.com/nix-community/home-manager/issues/1698
          specialArgs = { inherit inputs; };
          modules = mkDarwinModules {
            user = "ttak0422";
            host = "mbp";
            userConfig = ./modules/darwin/personal.nix;
            userHmConfig = ./modules/home-manager/personal.nix;
            userHomebrewConfig = ./modules/homebrew/personal.nix;
            inherit specialArgs;
          } ++ [
            ./modules/nix/prelude.nix
            { homebrew.brewPrefix = "/opt/homebrew/bin"; }
          ];
        in darwinSystem { inherit system modules specialArgs; };
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
          buildInputs = with pkgs; [ nixfmt pre-commit ];
          shellHook = "";
        };
      });
}
