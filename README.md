
GNULinradio
============

Ready for work embedded O.S. (LINARO) for the Zybo Board. It is only necessary to make some partitions with GParted and copy the files. **If you need to make some additional configuration or tr changes, you can chek out my post in which it is explained the whole installation process: http://mariolizanac.com/posts/linaro-for-the-zybo-board/**

**Linaro** is a collaborative engineering organization consolidating and optimizing open source operative system and tools for the ARM architecture. **www.linaro.org**

The **Zybo** (Zynq™ Board) is a feature-rich, ready-to-use, entry-level embedded software and digital circuit development platform built around the smallest member of the Xilinx Zynq-7000 family, the Z-7010. **http://store.digilentinc.com/zybo-zynq-7000-arm-fpga-soc-trainer-board/**



REQUIREMENTS
------------

The following equipment have been employed:

1. Linux Mint 18 Sarah (64 bits)

2. Vivado v2015.4

3. Zybo board

4. 16GB microSD

5. sudo apt-get install git build-essential

 


STEPS
------------

### 1. Get the Linaro file system ###

Download the Linaro file system with the code below.

Linaro image:

wget 'https://releases.linaro.org/15.06/ubuntu/vivid-images/gnome/linaro-vivid-gnome-20150618-705.tar.gz'
sudo tar -xvzf linaro-vivid-gnome-20150618-705.tar.gz
rm linaro-vivid-gnome-20150618-705.tar.gz
mv binary LINARO



### 2. Get you microSD ready ###


Insert your microSD in which you want to install LINARO, unmount it and delete all the partitions. Create one fat32 partition of 1 GiB, leaving at the beginning 4 MiB unallocated. Make other partition take the rest of the memory, selecting the ext4 file system. 

The copy the files which are inside the sd_boot folder (https://github.com/MarioLizanaC/Linaro-O.S.-for-Zybo/tree/master/sd_boot) into the first partition of the microSD. Finally you will have to make a temporal directory associated with the second partition of the microSD and copy the LINARO file system into it:

~~~bash
#Make sure you are inside the LINARO folder
mkdir /tmp/linaro
sudo mount /dev/mmcblk0p2 /tmp/linaro
sudo rsync -a ./ /tmp/linaro
~~~


 
REFERENCES 
------------
Most of the information have been obtained from the followink links: 

1. http://mariolizanac.com/posts/linaro-for-the-zybo-board/
2. http://www.instructables.com/id/Embedded-Linux-Tutorial-Zybo/
3. http://xillybus.com/xillinux
4. http://www.dbrss.org/zybo/tutorial4.html
5. https://ggallagher31.wordpress.com/







