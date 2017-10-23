#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in post-fs-data mode
# More info in the main Magisk thread

if [ ! -d /magisk/$MODID ]; then
  rm -f /magisk/.core/post-fs-data.d/$MODID.sh
  rm -rf /magisk/.core/post-fs-data.d/init.d
else
  if [ ! -d $SYS/etc/init.d ]; then
    mkdir $SYS/etc/init.d
    chmod 755 $SYS/etc/init.d
  fi

  if [ -f /magisk/$MODID/post-fs-data.sh ]; then
    mkdir /magisk/.core/post-fs-data.d/init.d
    chmod 755 /magisk/.core/post-fs-data.d/init.d
    mv -f /magisk/$MODID/post-fs-data.sh /magisk/.core/post-fs-data.d/$MODID.sh
    chmod 755 /magisk/.core/post-fs-data.d/$MODID.sh
  fi

  if [ -f $SYS/etc/init.d/0000liveboot ]; then
    ln -sfn $SYS/etc/init.d/0000liveboot /magisk/.core/post-fs-data.d/init.d/0000liveboot
  fi

  mkdir /magisk/.core/.hidden
  mv -f /magisk/.core/post-fs-data.d/$MODID.sh /magisk/.core/.hidden/$MODID.sh

  su -c sh /magisk/.core/post-fs-data.d/*
  su -c sh /magisk/.core/post-fs-data.d/init.d/*

  mv -f /magisk/.core/.hidden/$MODID.sh /magisk/.core/post-fs-data.d/$MODID.sh
  rm -f /magisk/.core/.hidden
fi
