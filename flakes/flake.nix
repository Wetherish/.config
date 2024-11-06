{
  inputs.hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # Example: You can pick a stable branch or a specific commit.

  outputs = { self, nixpkgs, hyprpanel, ... }@inputs: 
  let
    system = "x86_64-linux";  # Set this to your system, such as aarch64-linux for ARM or x86_64-linux for AMD64.
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        hyprpanel.overlay.${system}
      ];
    };
  in {
    # Example: if you're using home-manager or defining packages for a system.
    defaultPackage.${system} = pkgs.hyprpanel;
  };
}
