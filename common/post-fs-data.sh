#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in post-fs-data mode
# More info in the main Magisk thread

if [ ! -L /magisk/.core/service.d/init.d ]; then
  mkdir -p mkdir -p /magisk/.core/service.d/init.d
  ln -sfn /system/etc/init.d/* /magisk/.core/service.d/init.d
  if [ -f /system/etc/init.d/0000liveboot ]; then
    mkdir -p /magisk/.core/post-fs-data.d/init.d
	ln -sfn /system/etc/init.d/0000liveboot /magisk/.core/post-fs-data.d/init.d/0000liveboot
	rm -f /magisk/.core/service.d/init.d/0000liveboot
  fi
  reboot
fi

for FILE in /magisk/.core/post-fs-data.d/init.d/*; do
  su -c sh $FILE &
done
