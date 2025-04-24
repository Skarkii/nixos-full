# Commands
## Rebuild Nix-OS
Switch:
```sh
sudo nixos-rebuild switch
```
Test
```sh
sudo nixos-rebuild test
```

## Rebuild home-manager
```sh
home-manager switch
```

# Issues that have occured:
## error: ``file 'home-manager' was not found in the Nix search path (add it using $NIX_PATH or -I)``
Solution:
```
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```
