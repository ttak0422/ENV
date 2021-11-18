{
  description = "my ENV.";

  inputs = {
    nixpkgs-master.url = github:NixOS/nixpkgs/master;
    darwin.url = github:LnL7/nix-darwin/master;
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = 
    inputs @ 
    { self
    , nixpkgs
    , darwin
    , home-manager
    , ... 
    }: 
    let 
      inherit (nixpkgs.lib) attrValues;
      inherit (darwin.lib) darwinSystem;
      inherit (home-manager.lib) homeManagerConfiguration;

      nixpkgsConfig = { 
        config = { allowUnfree = true; };
        overlays = attrValues self.overlays;
      };
      mkHomeManagerConfig = args @ {
        user,
        userConfig ? "./modules/home-manager/tiny.nix",
        ...
      }: {
        imports = [];
      };
      mkDarwinModules = args @ {
        user,
        host,
        ...
      }: [
        ./modules/darwin/prelude.nix
        home-manager.darwinModules.home-manager(
          { config, pkgs, lib, ...}:{
        nixpkgs = nixpkgsConfig;
        # Hack to support legacy worklows that use `<nixpkgs>` etc.
        nix.nixPath = { nixpkgs = "$HOME/.config/nixpkgs/nixpkgs.nix"; };
        users.users.${user}.home = "/Users/${user}";
        home-manager = {
          useGlobalPkgs = true;
          users.${user} = mkHomeManagerConfig args;
        };
          })
      ];
    in
  {
    overlays = {
      pkgs-master = final: prev: {
        pkgs-master = import inputs.nixpkgs-master {
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
        };
      };
      darwinIntelCI = darwinSystem {
        system = "x86_64-darwin";
        modules = mkDarwinModules {
          user = "ci";
          host = "ci";
        };
      };
    };
  };
}
