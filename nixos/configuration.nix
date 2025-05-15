# configuration.nix
let
  hostName = "nixdesk";
in
{
  imports = [
    ./common.nix
    (./hosts + "/${hostName}.nix")
  ];
}
