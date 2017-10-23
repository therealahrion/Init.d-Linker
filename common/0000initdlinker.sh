#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in post-fs-data mode
# More info in the main Magisk thread

if [ ! -d /magisk/0000initdlinker ]; then
  rm -rf /magisk/.core/post-fs-data.d/init.d
  rm -rf /magisk/.core/service.d/init.d
  rm -f $0
  reboot
fi
