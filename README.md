# caarlos0/dotfiles

This is my latest dotfiles generation.

I've been experimenting with many different tools to manage them properly, from
Ansible to shell scripts, and never liked any of them that much, to be honest.

You can see the history on these repositories:

- [dotfiles.zsh](https://github.com/caarlos0/dotfiles.zsh)
- [dotfiles.fish](https://github.com/caarlos0/dotfiles.fish)

This is my most recent attempt, using nix.

It contains **home-manager**, **nixOS** and **nix-darwin** configuration
for several machines and VMs I use.

# Updating

To apply updates, simply run:

```bash
nix develop -c dot-apply

# pull, update flake, clean old, apply
nix develop -c dot-sync
```

# Clean up

```sh
nix develop -c dot-clean
```

# Create release

To create a release, run:

```bash
nix develop -c dot-release
```
