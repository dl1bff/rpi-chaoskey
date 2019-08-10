#/!bin/bash

if [ $# -lt 1 ]
then
  echo "Usage: make_module.sh (rpi3|rpi4)"
  exit 1
fi

TARGET=rpi3

if [ "$1" = "rpi4" ]
then
  TARGET=rpi4
fi


# get the tag of the lates release

RPI_KERNEL_RELEASE=`curl -s https://api.github.com/repos/raspberrypi/linux/tags | jq --raw-output '.[] | .name' | grep "^raspberrypi-kernel" | sort | tail -1`


if [ $? != 0 ]
then
  echo "an error occurred while getting the latest kernel version"
  exit 1
fi

if [ -z "$RPI_KERNEL_RELEASE" ]
then
  echo "release version of the kernel could not be determined"
  exit 1
fi

echo "target: $TARGET    getting release: $RPI_KERNEL_RELEASE"

rm -rf linux


git clone --depth=1 --branch "$RPI_KERNEL_RELEASE" https://github.com/raspberrypi/linux


cd linux

case "$TARGET" in
 "rpi3" )
  export KERNEL=kernel7
  make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig
  ;;
 "rpi4" )
  export KERNEL=kernel7l
  make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2711_defconfig
  ;;
esac



echo "CONFIG_USB_CHAOSKEY=m" >> .config

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-  drivers/usb/misc/chaoskey.ko


cd drivers/usb/misc

tar czf ../../../../chaoskey-${RPI_KERNEL_RELEASE}-${TARGET}.tgz chaoskey.ko


