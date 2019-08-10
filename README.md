# rpi-chaoskey
Compile Raspberry Pi Raspbian Kernel Module for the ChaosKey USB Random Number Generator

https://altusmetrum.org/ChaosKey/

https://www.raspberrypi.org/documentation/linux/kernel/building.md


    $ docker build -t rpi-chaoskey  github.com/dl1bff/rpi-chaoskey
    Sending build context to Docker daemon   5.12kB
    Step 1/6 : FROM debian:10
    ...
    Successfully built b2fe657c7dd7
    Successfully tagged rpi-chaoskey:latest
    $
    $
    $ docker run -it rpi-chaoskey bash
    root@c627559bce5b:/app# ./make_module.sh
    Usage: make_module.sh (rpi3|rpi4)
    root@c627559bce5b:/app# ./make_module.sh rpi3
    target: rpi3    getting release: raspberrypi-kernel_1.20190718-1
    Cloning into 'linux'...
    ...
        LD [M]  drivers/usb/misc/chaoskey.ko
    root@c627559bce5b:/app# ls
    chaoskey-raspberrypi-kernel_1.20190718-1-rpi3.tgz  linux  make_module.sh  tools
    root@c627559bce5b:/app# scp chaoskey-raspberrypi-kernel_1.20190718-1-rpi3.tgz    user@some.other.server:/tmp
    root@c627559bce5b:/app# exit
    $
    $ docker rm c627559bce5b
    $  
