#!/bin/bash

# This is a script to move TBS6910 code from the TBSDTV github source to an 
# official Linux kernel.
# 
# Please check the Makefile at the TBSDTV site to verify the Kernel version.
#
# The TBS6910 uses:
# - TBS ECP 3 interface
# - TAS2101 frontend
# - AV201x tuner
# Note: Every other TBSDTV driver is removed!

KERNEL_TBS="linux_media-latest"
KERNEL_SRC="linux-4.19.4"

### New files from TBS - tbsecp3 PCIe driver, TAS2101 frontend, AV201x tuner
cp -v -r ${KERNEL_TBS}/drivers/media/pci/tbsecp3 \
	 ${KERNEL_SRC}/drivers/media/pci/

cp -v ${KERNEL_TBS}/drivers/media/dvb-frontends/tas2101* \
      ${KERNEL_SRC}/drivers/media/dvb-frontends/

cp -v ${KERNEL_TBS}/drivers/media/tuners/av201x* \
      ${KERNEL_SRC}/drivers/media/tuners/

### Overwrite core DVB files
cp -v ${KERNEL_TBS}/include/media/dvb_frontend.h \
      ${KERNEL_SRC}/include/media/dvb_frontend.h

cp -v ${KERNEL_TBS}/include/uapi/linux/dvb/frontend.h \
      ${KERNEL_SRC}/include/uapi/linux/dvb/frontend.h

cp -v ${KERNEL_TBS}/drivers/media/dvb-core/dvb_frontend.c \
      ${KERNEL_SRC}/drivers/media/dvb-core/dvb_frontend.c

# Overwrite Kconfig & Makefiles
for i in $(echo {pci,pci/tbsecp3,tuners,dvb-frontends}/{Kconfig,Makefile}) 
do
	cp -v ${KERNEL_TBS}/drivers/media/$i \
              ${KERNEL_SRC}/drivers/media/$i
done

# Start to apply custom patches for TBS6910
cd ${KERNEL_SRC}

# Add kernel version support to tas2101.c
patch -p1 < ../backport-tbsdtv-patches/fix-tas2101.diff

# Remove unnecessary cards from tbsecp3-dvb.c
patch -p1 < ../backport-tbsdtv-patches/delete_non-tbs6910_code.diff

# Remove unnecessary cards from Kconfig / Makefile
patch -p1 < ../backport-tbsdtv-patches/delete_non-tbs6910_config.diff
