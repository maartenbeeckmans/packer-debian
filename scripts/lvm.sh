#!/bin/bash -eux

echo "Removing hack lv"
lvremove /dev/vg00/lv_hack --yes --autobackup y --debug --verbose --force

pvdisplay

vgdisplay

lvdisplay
