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
      url = "git+ssh://git@github.com/caiigee/anyrun-plugins.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypr-wpchanger = {
      url = "git+ssh://git@github.com/caiigee/hypr-wpchanger.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };    
  };

  outputs = { 
    self,
    nixpkgs,
    home-manager,
    anyrun,
    anyrun-plugins,
    hypr-wpchanger,
    ... 
  }: {
    nixosConfigurations = {
      hypr-flowX16 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./systems/flowX16/configuration.nix
          ./systems/flowX16/hardware-configuration.nix
          ./environments/hypr.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.caiigee = [
  	      ./home/caiigee.nix
	      ./home/firefox.nix
              ./home/zed.nix
              ./home/hypr.nix
	      ./home/anyrun.nix
              ./home/waybar.nix
              anyrun.homeManagerModules.default
            ];
	
            home-manager.extraSpecialArgs = { inherit anyrun anyrun-plugins hypr-wpchanger; };
          }
        ];
      };
    };
  };
}
