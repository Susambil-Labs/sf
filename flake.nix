{
  description = "Sofware foundations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { flake-parts
    , ...
    }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      
      perSystem = { pkgs, ... }:
      {
        
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.coq
            pkgs.coqPackages.stdlib
            pkgs.coqPackages.coq-lsp
            # pkgs.coqPackages.vscoq-language-server
            # (pkgs.writeShellScriptBin "vsrocqtop" ''
            #   exec ${pkgs.coqPackages.vscoq-language-server}/bin/vscoqtop "$@"
            # '')
          ];
        };
      };
    };
}