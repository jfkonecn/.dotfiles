# i3

## File Explorer

```sh
nautilus
```

## Install

```bash
sudo apt install i3
```

### Lock Screen (Might be already installed)

```bash
sudo apt install i3lock
```

## Fix Gnome Desktop

Add to you `.zshrc` script

```sh
#!/bin/bash

export XDG_CURRENT_DESKTOP=GNOME
```

## Monitor Fun

### List Monitors

```sh
xrandr
```

### Rotate Screen

```sh
xrandr --output <monitor-name> --rotate <left|right> --auto
```

### Multiple Monitors

```sh
xrandr --output <monitor-name> --auto --right-of <monitor-name>
```

## Issues

### Chrome won't Update

```sh
sudo software-properties-gtk
```

Go to other software and click the checkmark to enable the google source.

## Update Chrome

```sh
sudo apt --only-upgrade install google-chrome-stable
```
