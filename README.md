# My modular Guix Config and Dotfiles

This repository contains my (Non)Guix System, Guix Home and GNU Stow managed dotfiles.

The config is split into modules: shared settings live in base modules while machine-specific settings,
desktop enviornment and optional features are added on top.

## Guix Config

The configuration is built in layers:

`systems/base.scm` contains settings shared by all machines, like user, kernel, in my case nonguix kernel and firmware common packages and services shared by all my machines.

`systems/legion.scm` inherit from the base and adds machine specific settings such as filesystems, desktop choice and home enviornment.

The `desktop/` modules keep window-manager-specific configuration separate. This makes it easier to replace Sway with another Wayland compositor, an X11 window manager, or a desktop environment without rewriting the base configuration.

The `features/` directories contain optional groups of packages and services. Features can be added to or removed from a host configuration as needed.

## System and Home configurations

System configuration contains machine-wide packages and services.

Home configuration contains packages and services for the user. `home/common.scm` provides the shared user environment, while `home/legion.scm` combines it with other legion machine specific modules.

The home environment is attached to the operating system using `guix-home-service-type`. Because of this, running a system reconfigure updates both the operating system and Guix Home:

```bash
sudo guix system reconfigure -L ~/dotfiles ~/dotfiles/guix-config/systems/$(hostname).scm
```

A seperate `guix home reconfigure` command is not needed to update system.

## Dotfiles

The `stowable/` direcotry contains configs for programs that I use.

Link them with GNU Stow.

Guix manages most packages and services, while Stow manages regular configuration files and personal scripts.
