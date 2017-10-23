#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in late_start service mode
# More info in the main Magisk thread

if [ ! -d /magisk/$MODID ]; then
  rm -f /magisk/.core/service.d/$MODID.sh
  rm -rf /magisk/.core/service.d/init.d
  reboot
else
  if [ -f /magisk/$MODID/service.sh ]; then
    mkdir /magisk/.core/service.d/init.d
    chmod 755 /magisk/.core/service.d/init.d
    mv -f /magisk/$MODID/service.sh /magisk/.core/service.d/$MODID.sh
    chmod 755 /magisk/.core/service.d/$MODID.sh
    FIRSTBOOT=true
  fi

  ln -sfn $SYS/etc/init.d/* /magisk/.core/service.d/init.d

  if [ -f $SYS/etc/init.d/0000liveboot ]; then
    rm -f /magisk/.core/service.d/init.d/0000liveboot
  fi

  mkdir /magisk/.core/.hidden
  mv -f /magisk/.core/service.d/$MODID.sh /magisk/.core/.hidden/$MODID.sh

  su -c sh /magisk/.core/service.d/*
  su -c sh /magisk/.core/service.d/init.d/*

  mv -f /magisk/.core/.hidden/$MODID.sh /magisk/.core/service.d/$MODID.sh
  rm -r /magisk/.core/.hidden

  if [ $FIRSTBOOT == true ]; then
    reboot
  fi
fi
