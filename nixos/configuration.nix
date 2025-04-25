# configuration.nix
let
  hostName = "nixtop";
in
{
  imports = [
    ./common.nix
    (./hosts + "/${hostName}.nix")
  ];
}
