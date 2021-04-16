#!/bin/sh

sudo rm /usr/bin/vi
sudo rm /usr/bin/vim

sudo ln -s /usr/bin/nvim /usr/bin/vi
sudo ln -s /usr/bin/nvim /usr/bin/vim

