# My modular Guix Config and Dotfiles

This repository contains my (Non)Guix System, Guix Home and GNU Stow managed dotfiles.
Guix manages packages and services, while Stow manages app configs and scripts.

# Repo layout

```text
guix-config/
    systems/        # Machine definitions
    home/           # Guix Home enviornments
        desktop/    # Desktop specific modules
        features/   # Optional features

stowables/          # Traditional configs files managed with GNU Stow
```

The `systems/` and `home/` directories follow a similar layout. Both contain shared base modules, desktop-specific modules, optional features, and a machine-specific entry point (for example, legion.scm) that composes everything together.

## Systems

`systems/base.scm` contains configuration shared by every machine, such as users, Nonguix kernel and firmware, common packages and services.

Each machine inherits from base and adds its own hardware configuration, desktop enviornment and home enviornment. For example, `systems/legion.scm` defines configuration for my Lenovo Legion laptop.

## Desktop modules

Desktop modules keep window-manager-specific config seperate from the rest of the system. This makes it easy to switch between wayland compositors, x11 window-managers or any desktop enviornment without changing shared configuration.

## Features modules

The `features/` directories contain optional functionality, such as NVIDIA support, development tools or others. Features can be composed into a system as needed.

## Guix Home

Machine-wide packages and services belong in the system configuration.

User-specific packages and applications belong in Guix Home. `home/common.scm` provides shared home user enviornment. Like systems `home/` has `features/` `desktop/` where machine-specific modules are added.

Guix Home is attached to the operating system through `home/legion.scm` using guix-home-service-type, so a single command updates both operating system and user enviornment:

`sudo guix system reconfigure -L ~/dotfiles ~/dotfiles/guix-config/systems/$(hostname).scm`

A seperate `guix home reconfigure` is not needed.

## Dotfiles 

The `stowables/` directory contains config files that are managed by GNU Stow.

