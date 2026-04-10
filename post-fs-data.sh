#!/system/bin/sh
MODDIR=${0%/*}
chmod 644 $MODDIR/system/vendor/lib64/libmpp.so \
          $MODDIR/system/vendor/lib/libmpp.so \
          $MODDIR/system/vendor/lib64/libcodec2_rk_component.so \
          $MODDIR/system/vendor/lib/libcodec2_rk_component.so
chcon u:object_r:same_process_hal_file:s0 $MODDIR/system/vendor/lib64/libmpp.so $MODDIR/system/vendor/lib/libmpp.so
chcon u:object_r:vendor_file:s0 $MODDIR/system/vendor/lib64/libcodec2_rk_component.so $MODDIR/system/vendor/lib/libcodec2_rk_component.so
