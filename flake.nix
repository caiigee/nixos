{
  description = "caiigee's NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # My software
    anyrun-plugins = {
      url = "github:caiigee/anyrun-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self,
    nixpkgs,
    nur,
    home-manager,
    anyrun,
    anyrun-plugins,
    ... 
  }: let
    getSystemModules = hostname: desktop: [
      ./configuration.nix
      "./systems/${hostname}/configuration.nix"
      "./systems/${hostname}/hardware-configuration.nix"
      "./environments/${desktop}.nix"
    ];
    getUserModules = username: desktop: let
      names  = builtins.attrNames (builtins.readDir ./users/${username}/${desktop});
      modules = map (filename: "./users/${username}/${desktop}/${filename}") names;
    in [ "./users/${username}/user.nix" ] ++ modules;
  in {
    nixosConfigurations = {
      flowX16-Hyprland = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
          nur.modules.nixos.default
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
 	    home-manager.users.caiigee = {
              imports = [ anyrun.homeManagerModules.default ] ++ getUserModules "caiigee" "Hyprland";
            };
	    home-manager.extraSpecialArgs = { inherit anyrun anyrun-plugins; };
          }
        ] ++ getSystemModules "flowX16" "Hyprland";
      };
    };
  };
}
