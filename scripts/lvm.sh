#!/bin/bash -eux

echo "Removing hack lv"
lvremove /dev/vg_system/lv_hack --yes --autobackup y --debug --verbose --force
