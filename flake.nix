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
  };

  outputs =
    {
      nixpkgs,
      nur,
      home-manager,
      ...
    }:
    let
      getSystemModules =
        {
          system,
          hostname,
          environment,
        }:
        [
          (./. + "/systems/${system}/${hostname}/configuration.nix")
          (./. + "/systems/${system}/${hostname}/hardware-configuration.nix")
        ]
        ++ (
          if environment != null && environment != "" then
            [ (./. + "/environments/${environment}.nix") ]
          else
            [ ]
        );

      getUserModules =
        { username, environment }:
        let
          environmentDir = "/users/${username}/environments/${environment}";
          names = builtins.attrNames (builtins.readDir (./. + environmentDir));
          modules = map (filename: (./. + "${environmentDir}/${filename}")) names;
        in
        [ (./. + "/users/${username}/user.nix") ] ++ modules;
    in
    {
      nixosConfigurations = {
        flowX16-Hyprland = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [
              nur.modules.nixos.default
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.caiigee = {
                  imports = (
                    getUserModules {
                      username = "caiigee";
                      environment = "Hyprland";
                    }
                  );
                };
              }
            ]
            ++ (getSystemModules {
              system = "x86_64-linux";
              hostname = "flowX16";
              environment = "Hyprland";
            });
        };

        server = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = (
            getSystemModules {
              system = "x86_64-linux";
              hostname = "server";
              environment = "";
            }
          );
        };
      };
    };
}
