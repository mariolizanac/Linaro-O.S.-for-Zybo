
GNULinradio
============

IMPORTANT
------------

The commands are writing in such a way that you should only copy and paste them.

A lot of information have been obtained from: http://www.dbrss.org/zybo/tutorial4.html

!!!!!!!! -> Crear una variable que apunte a la carpeta GNULinradio

REQUIREMENTS
------------

The following equipment have been employed:

1. Linux Mint 18 Sarah

2. Zybo board

3. Vivado v2015.4 (64 bits)


sudo apt-get install gcc-arm-linux-gnueabi




STEPS
------------

### 1. Download necessary repositories ###


U-BOOT repository, from Digilent:
~~~bash
git clone -b master-next https://github.com/DigilentInc/u-boot-Digilent-Dev.git
~~~

Linux repository, from Digilent:
~~~bash
git clone -b master-next https://github.com/DigilentInc/Linux-Digilent-Dev.git
~~~

Linaro image:
~~~bash
wget 'https://releases.linaro.org/15.06/ubuntu/vivid-images/gnome/linaro-vivid-gnome-20150618-705.tar.gz'
sudo tar -xvzf linaro-vivid-gnome-20150618-705.tar.gz
rm linaro-vivid-gnome-20150618-705.tar.gz
mv binary LINARO
cd LINARO/boot/filesystem.dir
~~~

Zybo base system, from Digilent:
~~~bash
wget 'https://reference.digilentinc.com/_media/zybo:zybo_base_system.zip' -O zybo_base_system.zip
unzip zybo_base_system.zip -d unzip_folder	
cd unzip_folder/
mv zybo_base_system/ ../
cd ..
rm -rf unzip_folder/
rm zybo_base_system.zip
~~~


2. Download the Zybo base system for Vivado from the Digilent website 

!COPY FROM HERE:

wget 'https://reference.digilentinc.com/_media/zybo:zybo_base_system.zip' -O zybo_base_system.zip
unzip zybo_base_system.zip -d unzip_folder	
cd unzip_folder/
mv zybo_base_system/ ../
cd ..
rm -rf unzip_folder/
rm zybo_base_system.zip

!TO HERE

!Otra forma mas directa:
git clone -b master-next https://github.com/DigilentInc/u-boot-Digilent-Dev.git







3. Set necessary variables on the bash shell

mkdir sd_boot




4. Modify zynq_zybo.h, which is inside "u-boot-Digilent-Dev-master-next" folder. We should have the following lines:

	"sdboot=if mmcinfo; then " \
			"run uenvboot; " \
			"echo Copying Linux from SD to RAM... && " \
			"fatload mmc 0 0x3000000 ${kernel_image} && " \
			"fatload mmc 0 0x2A00000 ${devicetree_image} && " \
			"bootm 0x3000000 - 0x2A00000; " \
		"fi\0" \


5. Compile u-boot file


cd u-boot-Digilent-Dev-master

export ARCH=arm
export CROSS_COMPILE=arm-xilinx-linux-gnueabi-
export PATH=$PATH:/home/mario/Xilinx/SDK/2015.4/gnu/arm/lin/bin
export echo PATH=$PWD/tools:$PATH



make zynq_zybo_config
make
cp u-boot ../sd_boot/u-boot.elf



6. 

7. 



!!! Corregir esto con mi propio github, haciendo un repo nuevo, voy por el paso 4 de http://www.dbrss.org/zybo/tutorial4.html

Locate the ZYBO specific fsbl_hooks.c file in the zybo_base_system/source/vivado/SDK/fsbl folder and replace the one that was generated in the SDK fsbl project (-->   zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.sdk/fsbl/src)

project -> clean all
project -> build all


8.

9.

10.

The next step is to build the Linux kernel. Navigate to the Linux-Digilent-Dev folder we downloaded earlier. Now we are ready to compile the kernel. Make sure to run make on the xilinx_zynq_defconfig file to set up the configurations for the zynq chip before compiling the kernel.


cd Linux-Digilent-Dev

export ARCH=arm
export CROSS_COMPILE=arm-xilinx-linux-gnueabi-
export PATH=$PATH:	/home/mario/Xilinx/SDK/2015.4/gnu/arm/lin/bin
export echo PATH=$PWD/tools:$PATH

make xilinx_zynq_defconfig
make UIMAGE_LOADADDR=0x00008000 uImage modules -j32


11.

"Before we generate the device tree blob we need to make some slight adjustments to the zynq_zybo.dts file found Linux-Digilent_dev/arch/arm/boot/dts. Particularly line 44, 53, and 62. changing the clock prevented an error that occured after booting up to the root shell."


Change line 42 to:
		bootargs = "console=ttyPS0,115200 root=/dev/mmcblk0p2 rw earlyprintk rootfstype=ext4 rootwait";

Change line 51 to:
			clocks = <&clkc 2>;

Change line 60 to:
			clocks = <&clkc 2>;



make zynq-zybo.dtb
Copiar GNULinradio/Linux-Digilent-Dev/arch/arm/boot/dts/zynq-zybo.dtb a sd_boot y renombrarlo a devicetree.dtb


12.  
"There are a couple of ways to do this, the easier way is to use Gparted. A second way is to use the command line tool fdisk. If you do not have gparted it is fairly easy to download and install. Type sudo apt-get install gparted to install it and sudo gparted to run it. Once you have it install plug in your SD card and select it from the drop down window in the top left. If you have any information on the SD card make sure to back it up otherwise select the partition tab and unmount the partition then select and delete the partition. Select the check mark that appears, confirming you wish to delete the partition. Create two new partitions, the first with a beginning offset of 4 MiB. The first partition should be FAT32 and be 1 GiB, the second partition should be ext4 and can take the remaining space."





13. download LINARO

cd $GNULinradio
wget 'https://releases.linaro.org/15.06/ubuntu/vivid-images/gnome/linaro-vivid-gnome-20150618-705.tar.gz'
sudo tar -xvzf linaro-vivid-gnome-20150618-705.tar.gz
rm linaro-vivid-gnome-20150618-705.tar.gz
mv binary LINARO
cd LINARO/boot/filesystem.dir


14.

ATENCION A NO FORMARTEAR LO QU NO ES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1

mkdir /tmp/linaro
sudo mount /dev/mmcblk0p2 /tmp/linaro
sudo rsync -a ./ /tmp/linaro



15. Copy "uImage" file into the sd_boot folder
 









