To bootstrap

1. Clone locally into $HOME/workspace/nix-config
```
NIX_CONFIG_HOME=$HOME/workspace/nix-config
mkdir -p $NIX_CONFIG_HOME
git clone git@github.com:sentientmonkey/nix-config.git $NIX_CONFIG_HOME
```

2. Install determinate nix
```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

3. Install nix-darwin and point to config
```
nix run nix-darwin/master#darwin-rebuild -- switch --flake "$NIX_CONFIG_HOME?submodules=1"
```
