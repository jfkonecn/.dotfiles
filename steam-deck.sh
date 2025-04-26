#!/bin/bash

# dotnet, nvm, and go should be installed with brew

sudo steamos-readonly disable

sudo rm -r /etc/pacman.d/gnupg

sudo pacman-key --init

sudo pacman-key --populate

sudo pacman -S archlinux-keyring

sudo pacman-key --populate archlinux

sudo pacman --sync base-devel glibc linux-api-headers

sudo pacman -S openssl

sudo steamos-readonly enable
