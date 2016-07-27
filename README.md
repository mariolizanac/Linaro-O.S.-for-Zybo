
GNULinradio
============

IMPORTANT
------------

Readme not finished!!

The commands are writing in such a way that you should only copy and paste them.

A lot of information have been obtained from: http://www.dbrss.org/zybo/tutorial4.html

!!!!!!!! -> Crear una variable que apunte a la carpeta GNULinradio

REQUIREMENTS
------------

The following equipment have been employed:

1. Linux Mint 18 Sarah (64 bits)

2. Vivado v2015.4

3. Zybo board

4. 16GB microSD


sudo apt-get install gcc-arm-linux-gnueabi

 


STEPS
------------

### 1. Compiling U-Boot ###


It is necessary to download the u-boot repository using the master-next brach:

~~~bash
git clone -b master-next https://github.com/DigilentInc/u-boot-Digilent-Dev.git
~~~


And also to set up some configuration variables in the terminal:

~~~bash
export ARCH=armhf
export CROSS_COMPILE=arm-xilinx-linux-gnueabi-
#Modify the <path_to_xilinx> in the following command so it points to the xilinx installation folder
export PATH=$PATH:<path_to_xilinx>/Xilinx/SDK/2015.4/gnu/arm/lin/bin
#Run the following command inside the "u-boot-Digilent-Dev" folder
export echo PATH=$PWD/tools:$PATH
~~~


The default zynq_zybo.h file (inside "u-boot-Digilent-Dev-master-next" folder) will make the zybo load the ramdisk instead the linaro file system. Modify it so we have the following lines:

~~~C
	"sdboot=if mmcinfo; then " \
			"run uenvboot; " \
			"echo Copying Linux from SD to RAM... && " \
			"fatload mmc 0 0x3000000 ${kernel_image} && " \
			"fatload mmc 0 0x2A00000 ${devicetree_image} && " \
			"bootm 0x3000000 - 0x2A00000; " \
		"fi\0" \
~~~


Finally, let's specify the configuration for the zybo board and compile u-boot:

~~~bash
make zynq_zybo_config
make
~~~

### 2. Compiling the linux Kernel ###

Now we are going to compile the linux kernel and for that we need the repository below, master-next brach:
~~~bash
git clone -b master-next https://github.com/DigilentInc/Linux-Digilent-Dev.git
~~~


We need these configuration variables:
~~~bash
export ARCH=armhf
export CROSS_COMPILE=arm-xilinx-linux-gnueabi-
#Modify the <path_to_xilinx> in the following command so it points to the xilinx installation folder
export PATH=$PATH:<path_to_xilinx>/Xilinx/SDK/2015.4/gnu/arm/lin/bin
#Run the following command inside the "Linux-Digilent-Dev" folder
export echo PATH=$PWD/tools:$PATH
~~~



Compilation commands:
~~~bash
make xilinx_zynq_defconfig
make UIMAGE_LOADADDR=0x00008000 uImage modules -j32
~~~



### 3. Generating the bitstream ###

You can either generate the bitstream file from the beginning or use my Ready_for_Work_Zybo_Base_System repository.

OPTION A).

From the beginning you will have to follow the steps below:

	* Download the zybo base system from "https://reference.digilentinc.com/_media/zybo:zybo_base_system.zip"
	* Open it with Vivado
	* Modify the project if you need it
	* Update the IP Cores from previous versions
	* Run Synthesis, implementation and generate bitstream
	* Export hardware including the bitstream when asked.


OPTION B).


A ready for work zybo base system has been made so it is not necessary to follow the steps before. You can download it from "https://github.com/MarioLizanaC/Ready_for_Work_Zybo_Base_System", or:

~~~bash
git clone https://github.com/MarioLizanaC/Ready_for_Work_Zybo_Base_System.git
~~~

Open the project with Vivado. The project file is in the "source/vivado/hw/zybo_bsd" directory. Make sure the bistream has been exported, in Vivado: File -> Export -> Export Hardware -> Select "Include Bitsream" and OK.



### 4. Generating the BOOT.bin file ###


Launch Xilinx SDK from Vivado (File -> Launch SDK -> OK). Then create a new application project named FSBL: File -> New -> Application project -> Write "FSBL" inside the Project name box -> Next -> Select "Zynq FSBL" -> Finish.

Then replace the fsbl_hooks.c file (allocated in zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.sdk/FSBL/src) with the one that can be found in "zybo_base_system/source/vivado/SDK/fsbl/fsbl_hooks.c". We have to rebuild the project: Project -> Clean..., Project -> Build All.

In order to create the boot image (BOOT.bin file), go to Xilinx tools -> Create Boot Image. Select the path in which you want to generate the BOOT.bin file and select, **in order**, the following files:

-------  --------------------  ---------------------------------------------------------------------------------------
Order    Files                 Directory
-------  --------------------  ---------------------------------------------------------------------------------------
1        fsbl.elf              zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.sdk/fsbl/debug/

2        system_wrapper.bit    zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.sdk/system_wrapper_hw_platform_0/

3        u-boot.elf            u-boot-Digilent-Dev-master-next/
-------  --------------------  ---------------------------------------------------------------------------------------


### 5. Generating the devicetree.dtb file ###


First, it is important to change three things in the zynq_zybo.dts file in order to solve a clock problem and the correct loading of the linaro root system. This file can be found in the "Linux-Digilent_dev/arch/arm/boot/dts/" directory. You need to change the following lines, or download it from "X!X!X!X!X!X!X!X!X!X!X.com".

~~~
Change line 42 to:
	bootargs = "console=ttyPS0,115200 root=/dev/mmcblk0p2 rw earlyprintk rootfstype=ext4 rootwait";

Change line 51 to:
	clocks = <&clkc 2>;

Change line 60 to:
	clocks = <&clkc 2>;
~~~

Now you can go to the "Linux-Digilent_dev" folder and run:
~~~bash
make zynq-zybo.dtb
~~~

Copy the zynq-zybo.dtb file which is in "GNULinradio/Linux-Digilent-Dev/arch/arm/boot/dts/" to the sd_boot folder and rename it to devicetree.dtb.




### 6. Get the Linaro file system ready ###

Download the Linaro file system with the commands below. 

Linaro image:
~~~bash
wget 'https://releases.linaro.org/15.06/ubuntu/vivid-images/gnome/linaro-vivid-gnome-20150618-705.tar.gz'
sudo tar -xvzf linaro-vivid-gnome-20150618-705.tar.gz
rm linaro-vivid-gnome-20150618-705.tar.gz
mv binary LINARO
~~~



### 7. Get you microSD ready ###


Insert your microSD in which you want to install LINARO and delete all the partitions. Create one fat32 partition of 1 GiB, leaving at the beginning 4 MiB unallocated. Make other partition take the rest of the memory, selecting the ext4 file system. 



X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!X!
IN CONSTRUCTION
============

ATENCION A NO FORMARTEAR LO QU NO ES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1

mkdir /tmp/linaro
sudo mount /dev/mmcblk0p2 /tmp/linaro
sudo rsync -a ./ /tmp/linaro

Copy "uImage" file into the sd_boot folder
 









