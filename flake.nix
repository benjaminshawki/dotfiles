{
  description = "Main flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";

    # use the following for unstable:
    # nixpkgs.url = "nixpkgs/nixos-unstable";

    # or any branch you want:
    # nixpkgs.url = "nixpkgs/{BRANCH-NAME}";
  };

  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        benjamin = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./nixos/configuration.nix ];
      };
    };
  };
}
