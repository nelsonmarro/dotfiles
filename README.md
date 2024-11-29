# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```bash
sudo pacman -S git
```

### Stow

```bash
sudo pacman -S stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```bash
git clone git@github.com:nelsonmarro/dotfiles.git
cd dotfiles
```

then use GNU stow to create symlinks

```bash
stow --adopt .
```
