{
  description = "Environment";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
      # Override the Nix package set to allow unfree packages
        pkgs = import nixpkgs {
          system = system; 
          config.allowUnfree = true; 
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            uv
            python311
          ];

          shellHook = ''
            echo "Nix dev shell active."
          '';
        };
      }
    );
}
