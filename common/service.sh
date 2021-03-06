#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in late_start service mode
# More info in the main Magisk thread

test ! -d /magisk/0000initdlinker && { rm -f $0; exit; }

for FILE in /system/etc/init.d/*; do
  test "$FILE" != "/system/etc/init.d/0000liveboot" && su -c sh $FILE &
done
