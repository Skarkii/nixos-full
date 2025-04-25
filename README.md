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

## Search for missing dependecy
```sh
nix-locate "libgthread2-0.so.0"
```

## Update locate db
```sh
nix-index-update
```

# Issues that have occured:
## error:
```sh
file 'home-manager' was not found in the Nix search path (add it using $NIX_PATH or -I)
```
Solution:
Add the correct version of home-manager, i.e. 24.11:
```
nix-channel --add https://github.com/rycee/home-manager/archive/release-24.11.tar.gz home-manager
nix-channel --update
```

## error:
Version mismatch
```sh
trace: warning: You are using

  Home Manager version 23.05 and
  Nixpkgs version 23.11.
```
Solution ensure ``nix-channel --list`` that home manager matches nix version, otherwise update, i.e. v24.11:
``nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager``
