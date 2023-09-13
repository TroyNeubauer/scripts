#!/bin/sh

sudo rm -f /usr/bin/vi
sudo rm -f /usr/bin/vim

sudo ln -s /usr/bin/nvim /usr/bin/vi
sudo ln -s /usr/bin/nvim /usr/bin/vim

