
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z010clg400-1

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set BTNs_4Bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 BTNs_4Bits ]
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set IIC_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_0 ]
  set SWs_4Bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 SWs_4Bits ]

  # Create ports
  set AC_BCLK [ create_bd_port -dir O -from 0 -to 0 AC_BCLK ]
  set AC_MCLK [ create_bd_port -dir O AC_MCLK ]
  set AC_MUTE_N [ create_bd_port -dir O -from 0 -to 0 AC_MUTE_N ]
  set AC_PBLRC [ create_bd_port -dir O -from 0 -to 0 AC_PBLRC ]
  set AC_RECLRC [ create_bd_port -dir O -from 0 -to 0 AC_RECLRC ]
  set AC_SDATA_I [ create_bd_port -dir I AC_SDATA_I ]
  set AC_SDATA_O [ create_bd_port -dir O -from 0 -to 0 AC_SDATA_O ]
  set BLUE_O [ create_bd_port -dir O -from 4 -to 0 BLUE_O ]
  set GREEN_O [ create_bd_port -dir O -from 5 -to 0 GREEN_O ]
  set HDMI_CLK_N [ create_bd_port -dir O HDMI_CLK_N ]
  set HDMI_CLK_P [ create_bd_port -dir O HDMI_CLK_P ]
  set HDMI_D0_N [ create_bd_port -dir O HDMI_D0_N ]
  set HDMI_D0_P [ create_bd_port -dir O HDMI_D0_P ]
  set HDMI_D1_N [ create_bd_port -dir O HDMI_D1_N ]
  set HDMI_D1_P [ create_bd_port -dir O HDMI_D1_P ]
  set HDMI_D2_N [ create_bd_port -dir O HDMI_D2_N ]
  set HDMI_D2_P [ create_bd_port -dir O HDMI_D2_P ]
  set HDMI_OEN [ create_bd_port -dir O -from 0 -to 0 HDMI_OEN ]
  set HSYNC_O [ create_bd_port -dir O HSYNC_O ]
  set RED_O [ create_bd_port -dir O -from 4 -to 0 RED_O ]
  set VSYNC_O [ create_bd_port -dir O VSYNC_O ]
  set led [ create_bd_port -dir O -from 3 -to 0 led ]

  # Create instance: BTNs_4Bits, and set properties
  set BTNs_4Bits [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 BTNs_4Bits ]
  set_property -dict [ list \
CONFIG.C_ALL_INPUTS {1} \
CONFIG.C_GPIO_WIDTH {4} \
 ] $BTNs_4Bits

  # Create instance: SWs_4Bits, and set properties
  set SWs_4Bits [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 SWs_4Bits ]
  set_property -dict [ list \
CONFIG.C_ALL_INPUTS {1} \
CONFIG.C_GPIO_WIDTH {4} \
 ] $SWs_4Bits

  # Create instance: axi_dispctrl_0, and set properties
  set axi_dispctrl_0 [ create_bd_cell -type ip -vlnv Digilent:digilent:axi_dispctrl:1.0 axi_dispctrl_0 ]
  set_property -dict [ list \
CONFIG.C_BLUE_WIDTH {5} \
CONFIG.C_GREEN_WIDTH {6} \
CONFIG.C_RED_WIDTH {5} \
 ] $axi_dispctrl_0

  # Create instance: axi_dispctrl_1, and set properties
  set axi_dispctrl_1 [ create_bd_cell -type ip -vlnv Digilent:digilent:axi_dispctrl:1.0 axi_dispctrl_1 ]
  set_property -dict [ list \
CONFIG.C_USE_BUFR_DIV5 {1} \
 ] $axi_dispctrl_1

  # Create instance: axi_i2s_adi_1, and set properties
  set axi_i2s_adi_1 [ create_bd_cell -type ip -vlnv analogdeviceinc.com:adi:axi_i2s_adi:1.0 axi_i2s_adi_1 ]
  set_property -dict [ list \
CONFIG.C_DMA_TYPE {1} \
 ] $axi_i2s_adi_1

  # Create instance: axi_mem_intercon, and set properties
  set axi_mem_intercon [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_mem_intercon ]
  set_property -dict [ list \
CONFIG.ENABLE_ADVANCED_OPTIONS {0} \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {2} \
 ] $axi_mem_intercon

  # Create instance: axi_protocol_converter_0, and set properties
  set axi_protocol_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_protocol_converter:2.1 axi_protocol_converter_0 ]
  set_property -dict [ list \
CONFIG.MI_PROTOCOL {AXI4LITE} \
 ] $axi_protocol_converter_0

  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_0 ]
  set_property -dict [ list \
CONFIG.c_enable_debug_all {1} \
CONFIG.c_include_s2mm {0} \
CONFIG.c_m_axi_mm2s_data_width {64} \
CONFIG.c_mm2s_genlock_mode {1} \
CONFIG.c_mm2s_linebuffer_depth {2048} \
CONFIG.c_mm2s_max_burst_length {16} \
CONFIG.c_use_mm2s_fsync {1} \
 ] $axi_vdma_0

  # Create instance: axi_vdma_1, and set properties
  set axi_vdma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_1 ]
  set_property -dict [ list \
CONFIG.c_enable_debug_all {1} \
CONFIG.c_include_s2mm {0} \
CONFIG.c_m_axi_mm2s_data_width {64} \
CONFIG.c_mm2s_genlock_mode {1} \
CONFIG.c_mm2s_linebuffer_depth {2048} \
CONFIG.c_mm2s_max_burst_length {16} \
CONFIG.c_use_mm2s_fsync {1} \
 ] $axi_vdma_1

  # Create instance: ground, and set properties
  set ground [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 ground ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $ground

  # Create instance: hdmi_tx_0, and set properties
  set hdmi_tx_0 [ create_bd_cell -type ip -vlnv digilentinc.com:digilent:hdmi_tx:1.0 hdmi_tx_0 ]
  set_property -dict [ list \
CONFIG.C_BLUE_WIDTH {8} \
CONFIG.C_GREEN_WIDTH {8} \
CONFIG.C_RED_WIDTH {8} \
 ] $hdmi_tx_0

  # Create instance: myLED_0, and set properties
  set myLED_0 [ create_bd_cell -type ip -vlnv MarioLizanaC.com:user:myLED:1.0 myLED_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_CLK2_PORT {1} \
CONFIG.PCW_EN_RST1_PORT {1} \
CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {DDR PLL} \
CONFIG.PCW_FCLK2_PERIPHERAL_CLKSRC {ARM PLL} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {150} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {12.288} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_IMPORT_BOARD_PRESET {./lib/xml/ZYBO_zynq_def.xml} \
CONFIG.PCW_MIO_47_PULLUP {enabled} \
CONFIG.PCW_SD0_GRP_WP_ENABLE {1} \
CONFIG.PCW_USE_DMA0 {1} \
CONFIG.PCW_USE_DMA1 {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.PCW_USE_S_AXI_HP1 {0} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.ENABLE_ADVANCED_OPTIONS {0} \
CONFIG.M00_HAS_REGSLICE {4} \
CONFIG.M01_HAS_REGSLICE {4} \
CONFIG.M02_HAS_REGSLICE {4} \
CONFIG.M03_HAS_REGSLICE {4} \
CONFIG.M04_HAS_REGSLICE {4} \
CONFIG.M05_HAS_REGSLICE {4} \
CONFIG.M06_HAS_REGSLICE {4} \
CONFIG.M07_HAS_REGSLICE {4} \
CONFIG.NUM_MI {8} \
CONFIG.STRATEGY {1} \
 ] $processing_system7_0_axi_periph

  # Create instance: vdd, and set properties
  set vdd [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 vdd ]

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {6} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net BTNs_4Bits_GPIO [get_bd_intf_ports BTNs_4Bits] [get_bd_intf_pins BTNs_4Bits/GPIO]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins axi_mem_intercon/S01_AXI] [get_bd_intf_pins axi_vdma_1/M_AXI_MM2S]
  connect_bd_intf_net -intf_net SWs_4Bits_GPIO [get_bd_intf_ports SWs_4Bits] [get_bd_intf_pins SWs_4Bits/GPIO]
  connect_bd_intf_net -intf_net axi_i2s_adi_1_DMA_RX_REQ [get_bd_intf_pins axi_i2s_adi_1/DMA_RX_REQ] [get_bd_intf_pins processing_system7_0/DMA1_REQ]
  connect_bd_intf_net -intf_net axi_i2s_adi_1_DMA_TX_REQ [get_bd_intf_pins axi_i2s_adi_1/DMA_TX_REQ] [get_bd_intf_pins processing_system7_0/DMA0_REQ]
  connect_bd_intf_net -intf_net axi_mem_intercon_M00_AXI [get_bd_intf_pins axi_mem_intercon/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_dispctrl_0/S_AXIS_MM2S] [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins axi_mem_intercon/S00_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_1_M_AXIS_MM2S [get_bd_intf_pins axi_dispctrl_1/S_AXIS_MM2S] [get_bd_intf_pins axi_vdma_1/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_DMA0_ACK [get_bd_intf_pins axi_i2s_adi_1/DMA_TX_ACK] [get_bd_intf_pins processing_system7_0/DMA0_ACK]
  connect_bd_intf_net -intf_net processing_system7_0_DMA1_ACK [get_bd_intf_pins axi_i2s_adi_1/DMA_RX_ACK] [get_bd_intf_pins processing_system7_0/DMA1_ACK]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_IIC_0 [get_bd_intf_ports IIC_0] [get_bd_intf_pins processing_system7_0/IIC_0]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins axi_protocol_converter_0/M_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP1 [get_bd_intf_pins axi_protocol_converter_0/S_AXI] [get_bd_intf_pins processing_system7_0/M_AXI_GP0]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins myLED_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins BTNs_4Bits/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins SWs_4Bits/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins axi_dispctrl_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M04_AXI [get_bd_intf_pins axi_vdma_0/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M05_AXI [get_bd_intf_pins axi_vdma_1/S_AXI_LITE] [get_bd_intf_pins processing_system7_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M06_AXI [get_bd_intf_pins axi_dispctrl_1/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M08_AXI [get_bd_intf_pins axi_i2s_adi_1/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M07_AXI]

  # Create port connections
  connect_bd_net -net AC_SDATA_I_1 [get_bd_ports AC_SDATA_I] [get_bd_pins axi_i2s_adi_1/SDATA_I]
  connect_bd_net -net axi_dispctrl_0_BLUE_O [get_bd_ports BLUE_O] [get_bd_pins axi_dispctrl_0/BLUE_O]
  connect_bd_net -net axi_dispctrl_0_FSYNC_O [get_bd_pins axi_dispctrl_0/FSYNC_O] [get_bd_pins axi_vdma_0/mm2s_fsync]
  connect_bd_net -net axi_dispctrl_0_GREEN_O [get_bd_ports GREEN_O] [get_bd_pins axi_dispctrl_0/GREEN_O]
  connect_bd_net -net axi_dispctrl_0_HSYNC_O [get_bd_ports HSYNC_O] [get_bd_pins axi_dispctrl_0/HSYNC_O]
  connect_bd_net -net axi_dispctrl_0_PXL_CLK_O [get_bd_pins axi_dispctrl_0/PXL_CLK_O] [get_bd_pins axi_dispctrl_0/s_axis_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk]
  connect_bd_net -net axi_dispctrl_0_RED_O [get_bd_ports RED_O] [get_bd_pins axi_dispctrl_0/RED_O]
  connect_bd_net -net axi_dispctrl_0_VSYNC_O [get_bd_ports VSYNC_O] [get_bd_pins axi_dispctrl_0/VSYNC_O]
  connect_bd_net -net axi_dispctrl_1_BLUE_O [get_bd_pins axi_dispctrl_1/BLUE_O] [get_bd_pins hdmi_tx_0/VGA_B]
  connect_bd_net -net axi_dispctrl_1_DE_O [get_bd_pins axi_dispctrl_1/DE_O] [get_bd_pins hdmi_tx_0/VGA_DE]
  connect_bd_net -net axi_dispctrl_1_FSYNC_O [get_bd_pins axi_dispctrl_1/FSYNC_O] [get_bd_pins axi_vdma_1/mm2s_fsync]
  connect_bd_net -net axi_dispctrl_1_GREEN_O [get_bd_pins axi_dispctrl_1/GREEN_O] [get_bd_pins hdmi_tx_0/VGA_G]
  connect_bd_net -net axi_dispctrl_1_HSYNC_O [get_bd_pins axi_dispctrl_1/HSYNC_O] [get_bd_pins hdmi_tx_0/VGA_HS]
  connect_bd_net -net axi_dispctrl_1_LOCKED_O [get_bd_pins axi_dispctrl_1/LOCKED_O] [get_bd_pins hdmi_tx_0/LOCKED_I]
  connect_bd_net -net axi_dispctrl_1_PXL_CLK_5X_O [get_bd_pins axi_dispctrl_1/PXL_CLK_5X_O] [get_bd_pins hdmi_tx_0/PXLCLK_5X_I]
  connect_bd_net -net axi_dispctrl_1_PXL_CLK_O [get_bd_pins axi_dispctrl_1/PXL_CLK_O] [get_bd_pins axi_dispctrl_1/s_axis_mm2s_aclk] [get_bd_pins axi_vdma_1/m_axis_mm2s_aclk] [get_bd_pins hdmi_tx_0/PXLCLK_I]
  connect_bd_net -net axi_dispctrl_1_RED_O [get_bd_pins axi_dispctrl_1/RED_O] [get_bd_pins hdmi_tx_0/VGA_R]
  connect_bd_net -net axi_dispctrl_1_VSYNC_O [get_bd_pins axi_dispctrl_1/VSYNC_O] [get_bd_pins hdmi_tx_0/VGA_VS]
  connect_bd_net -net axi_i2s_adi_1_BCLK_O [get_bd_ports AC_BCLK] [get_bd_pins axi_i2s_adi_1/BCLK_O]
  connect_bd_net -net axi_i2s_adi_1_LRCLK_O [get_bd_ports AC_PBLRC] [get_bd_ports AC_RECLRC] [get_bd_pins axi_i2s_adi_1/LRCLK_O]
  connect_bd_net -net axi_i2s_adi_1_MUTEN_O [get_bd_ports AC_MUTE_N] [get_bd_pins axi_i2s_adi_1/MUTEN_O]
  connect_bd_net -net axi_i2s_adi_1_SDATA_O [get_bd_ports AC_SDATA_O] [get_bd_pins axi_i2s_adi_1/SDATA_O]
  connect_bd_net -net axi_vdma_0_m_axis_mm2s_tkeep [get_bd_pins axi_dispctrl_0/s_axis_mm2s_tstrb] [get_bd_pins axi_vdma_0/m_axis_mm2s_tkeep]
  connect_bd_net -net axi_vdma_1_m_axis_mm2s_tkeep [get_bd_pins axi_dispctrl_1/s_axis_mm2s_tstrb] [get_bd_pins axi_vdma_1/m_axis_mm2s_tkeep]
  connect_bd_net -net hdmi_tx_0_HDMI_CLK_N [get_bd_ports HDMI_CLK_N] [get_bd_pins hdmi_tx_0/HDMI_CLK_N]
  connect_bd_net -net hdmi_tx_0_HDMI_CLK_P [get_bd_ports HDMI_CLK_P] [get_bd_pins hdmi_tx_0/HDMI_CLK_P]
  connect_bd_net -net hdmi_tx_0_HDMI_D0_N [get_bd_ports HDMI_D0_N] [get_bd_pins hdmi_tx_0/HDMI_D0_N]
  connect_bd_net -net hdmi_tx_0_HDMI_D0_P [get_bd_ports HDMI_D0_P] [get_bd_pins hdmi_tx_0/HDMI_D0_P]
  connect_bd_net -net hdmi_tx_0_HDMI_D1_N [get_bd_ports HDMI_D1_N] [get_bd_pins hdmi_tx_0/HDMI_D1_N]
  connect_bd_net -net hdmi_tx_0_HDMI_D1_P [get_bd_ports HDMI_D1_P] [get_bd_pins hdmi_tx_0/HDMI_D1_P]
  connect_bd_net -net hdmi_tx_0_HDMI_D2_N [get_bd_ports HDMI_D2_N] [get_bd_pins hdmi_tx_0/HDMI_D2_N]
  connect_bd_net -net hdmi_tx_0_HDMI_D2_P [get_bd_ports HDMI_D2_P] [get_bd_pins hdmi_tx_0/HDMI_D2_P]
  connect_bd_net -net myLED_0_led [get_bd_ports led] [get_bd_pins myLED_0/led]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins BTNs_4Bits/s_axi_aclk] [get_bd_pins SWs_4Bits/s_axi_aclk] [get_bd_pins axi_dispctrl_0/REF_CLK_I] [get_bd_pins axi_dispctrl_0/s_axi_aclk] [get_bd_pins axi_dispctrl_1/REF_CLK_I] [get_bd_pins axi_dispctrl_1/s_axi_aclk] [get_bd_pins axi_i2s_adi_1/DMA_REQ_RX_ACLK] [get_bd_pins axi_i2s_adi_1/DMA_REQ_TX_ACLK] [get_bd_pins axi_i2s_adi_1/S_AXI_ACLK] [get_bd_pins axi_protocol_converter_0/aclk] [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axi_vdma_1/s_axi_lite_aclk] [get_bd_pins myLED_0/s_axi_aclk] [get_bd_pins processing_system7_0/DMA0_ACLK] [get_bd_pins processing_system7_0/DMA1_ACLK] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/M05_ACLK] [get_bd_pins processing_system7_0_axi_periph/M06_ACLK] [get_bd_pins processing_system7_0_axi_periph/M07_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins axi_mem_intercon/ACLK] [get_bd_pins axi_mem_intercon/M00_ACLK] [get_bd_pins axi_mem_intercon/S00_ACLK] [get_bd_pins axi_mem_intercon/S01_ACLK] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_1/m_axi_mm2s_aclk] [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK]
  connect_bd_net -net processing_system7_0_FCLK_CLK2 [get_bd_ports AC_MCLK] [get_bd_pins axi_i2s_adi_1/DATA_CLK_I] [get_bd_pins processing_system7_0/FCLK_CLK2]
  connect_bd_net -net rst_processing_system7_0_97M_interconnect_aresetn [get_bd_pins axi_mem_intercon/ARESETN] [get_bd_pins axi_protocol_converter_0/aresetn] [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins processing_system7_0_axi_periph/ARESETN]
  connect_bd_net -net rst_processing_system7_0_97M_peripheral_aresetn [get_bd_pins BTNs_4Bits/s_axi_aresetn] [get_bd_pins SWs_4Bits/s_axi_aresetn] [get_bd_pins axi_dispctrl_0/s_axi_aresetn] [get_bd_pins axi_dispctrl_0/s_axis_mm2s_aresetn] [get_bd_pins axi_dispctrl_1/s_axi_aresetn] [get_bd_pins axi_dispctrl_1/s_axis_mm2s_aresetn] [get_bd_pins axi_i2s_adi_1/DMA_REQ_RX_RSTN] [get_bd_pins axi_i2s_adi_1/DMA_REQ_TX_RSTN] [get_bd_pins axi_i2s_adi_1/S_AXI_ARESETN] [get_bd_pins axi_mem_intercon/M00_ARESETN] [get_bd_pins axi_mem_intercon/S00_ARESETN] [get_bd_pins axi_mem_intercon/S01_ARESETN] [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins axi_vdma_1/axi_resetn] [get_bd_pins myLED_0/s_axi_aresetn] [get_bd_pins processing_system7_0/FCLK_RESET1_N] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M05_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M06_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M07_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN]
  connect_bd_net -net vdd_const [get_bd_ports HDMI_OEN] [get_bd_pins vdd/dout]
  connect_bd_net -net xlconstant_0_const [get_bd_pins ground/dout] [get_bd_pins hdmi_tx_0/RST_I] [get_bd_pins processing_system7_0/SDIO0_WP]
  connect_bd_net -net xlconstant_0_const1 [get_bd_pins axi_vdma_0/mm2s_frame_ptr_in] [get_bd_pins axi_vdma_1/mm2s_frame_ptr_in] [get_bd_pins xlconstant_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_1/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x41200000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs BTNs_4Bits/S_AXI/Reg] SEG_BTNs_4Bits_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x41220000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs SWs_4Bits/S_AXI/Reg] SEG_SWs_4Bits_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dispctrl_0/S_AXI/S_AXI_reg] SEG_axi_dispctrl_0_S_AXI_reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_dispctrl_1/S_AXI/S_AXI_reg] SEG_axi_dispctrl_1_S_AXI_reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_i2s_adi_1/S_AXI/S_AXI_reg] SEG_axi_i2s_adi_1_S_AXI_reg
  create_bd_addr_seg -range 0x10000 -offset 0x43000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43010000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_1/S_AXI_LITE/Reg] SEG_axi_vdma_1_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C30000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs myLED_0/S_AXI/S_AXI_reg] SEG_myLED_0_S_AXI_reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.8
#  -string -flagsOSRD
preplace port HDMI_CLK_P -pg 1 -y 1630 -defaultsOSRD
preplace port DDR -pg 1 -y 460 -defaultsOSRD
preplace port AC_MCLK -pg 1 -y 20 -defaultsOSRD
preplace port HDMI_D2_N -pg 1 -y 1690 -defaultsOSRD
preplace port HDMI_D2_P -pg 1 -y 1670 -defaultsOSRD
preplace port HDMI_D1_N -pg 1 -y 1730 -defaultsOSRD
preplace port HDMI_D0_N -pg 1 -y 1770 -defaultsOSRD
preplace port SWs_4Bits -pg 1 -y 890 -defaultsOSRD
preplace port HDMI_D1_P -pg 1 -y 1710 -defaultsOSRD
preplace port HDMI_D0_P -pg 1 -y 1750 -defaultsOSRD
preplace port IIC_0 -pg 1 -y 500 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 480 -defaultsOSRD
preplace port BTNs_4Bits -pg 1 -y 400 -defaultsOSRD
preplace port HSYNC_O -pg 1 -y 650 -defaultsOSRD
preplace port VSYNC_O -pg 1 -y 670 -defaultsOSRD
preplace port AC_SDATA_I -pg 1 -y 1500 -defaultsOSRD
preplace port HDMI_CLK_N -pg 1 -y 1650 -defaultsOSRD
preplace portBus AC_RECLRC -pg 1 -y 180 -defaultsOSRD
preplace portBus AC_MUTE_N -pg 1 -y 220 -defaultsOSRD
preplace portBus AC_SDATA_O -pg 1 -y 200 -defaultsOSRD
preplace portBus AC_PBLRC -pg 1 -y 160 -defaultsOSRD
preplace portBus led -pg 1 -y 1020 -defaultsOSRD
preplace portBus BLUE_O -pg 1 -y 750 -defaultsOSRD
preplace portBus RED_O -pg 1 -y 710 -defaultsOSRD
preplace portBus GREEN_O -pg 1 -y 730 -defaultsOSRD
preplace portBus AC_BCLK -pg 1 -y 140 -defaultsOSRD
preplace portBus HDMI_OEN -pg 1 -y 1450 -defaultsOSRD
preplace inst vdd -pg 1 -lvl 7 -y 1450 -defaultsOSRD
preplace inst hdmi_tx_0 -pg 1 -lvl 7 -y 1700 -defaultsOSRD
preplace inst axi_vdma_0 -pg 1 -lvl 2 -y 880 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 1 -y 940 -defaultsOSRD
preplace inst axi_vdma_1 -pg 1 -lvl 2 -y 1350 -defaultsOSRD
preplace inst axi_protocol_converter_0 -pg 1 -lvl 5 -y 720 -defaultsOSRD
preplace inst SWs_4Bits -pg 1 -lvl 7 -y 890 -defaultsOSRD
preplace inst axi_dispctrl_0 -pg 1 -lvl 7 -y 670 -defaultsOSRD
preplace inst axi_dispctrl_1 -pg 1 -lvl 7 -y 1240 -defaultsOSRD
preplace inst BTNs_4Bits -pg 1 -lvl 7 -y 400 -defaultsOSRD
preplace inst myLED_0 -pg 1 -lvl 7 -y 1020 -defaultsOSRD
preplace inst axi_i2s_adi_1 -pg 1 -lvl 7 -y 170 -defaultsOSRD
preplace inst ground -pg 1 -lvl 6 -y 1560 -defaultsOSRD
preplace inst axi_mem_intercon -pg 1 -lvl 3 -y 620 -defaultsOSRD
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 6 -y 900 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 4 -y 580 -defaultsOSRD
preplace netloc processing_system7_0_DDR 1 4 4 NJ 460 NJ 460 NJ 470 NJ
preplace netloc vdd_const 1 7 1 NJ
preplace netloc AC_SDATA_I_1 1 0 7 NJ 150 NJ 150 NJ 150 NJ 150 NJ 150 NJ 150 NJ
preplace netloc hdmi_tx_0_HDMI_D2_P 1 7 1 NJ
preplace netloc hdmi_tx_0_HDMI_D1_N 1 7 1 NJ
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 6 1 2230
preplace netloc processing_system7_0_axi_periph_M08_AXI 1 6 1 2220
preplace netloc processing_system7_0_axi_periph_M03_AXI 1 6 1 2250
preplace netloc axi_i2s_adi_1_DMA_RX_REQ 1 3 5 1040 770 NJ 520 NJ 520 NJ 520 2680
preplace netloc xlconstant_0_const1 1 1 1 160
preplace netloc axi_dispctrl_1_HSYNC_O 1 6 2 2280 1550 2710
preplace netloc axi_dispctrl_1_GREEN_O 1 6 2 2240 1510 2640
preplace netloc axi_dispctrl_0_PXL_CLK_O 1 1 7 210 700 NJ 790 NJ 820 NJ 570 NJ 570 2270 820 2630
preplace netloc processing_system7_0_M_AXI_GP0 1 5 1 1860
preplace netloc axi_vdma_0_M_AXI_MM2S 1 2 1 630
preplace netloc hdmi_tx_0_HDMI_D1_P 1 7 1 NJ
preplace netloc processing_system7_0_axi_periph_M05_AXI 1 1 6 230 1160 NJ 1160 NJ 1160 NJ 1160 NJ 1160 2170
preplace netloc processing_system7_0_M_AXI_GP1 1 4 1 1560
preplace netloc axi_vdma_0_M_AXIS_MM2S 1 2 5 N 800 NJ 800 NJ 600 NJ 600 NJ
preplace netloc rst_processing_system7_0_97M_peripheral_aresetn 1 1 6 170 690 700 870 NJ 870 1520 800 1880 640 2210
preplace netloc processing_system7_0_IIC_0 1 4 4 NJ 500 NJ 500 NJ 500 NJ
preplace netloc BTNs_4Bits_GPIO 1 7 1 NJ
preplace netloc axi_mem_intercon_M00_AXI 1 3 1 1000
preplace netloc axi_dispctrl_1_PXL_CLK_5X_O 1 6 2 2270 1530 2720
preplace netloc axi_dispctrl_1_DE_O 1 6 2 2230 1400 2650
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 6 1 N
preplace netloc processing_system7_0_DMA0_ACK 1 4 3 NJ 90 NJ 90 N
preplace netloc xlconstant_0_const 1 4 3 NJ 540 NJ 540 2200
preplace netloc axi_vdma_0_m_axis_mm2s_tkeep 1 2 5 N 820 NJ 830 NJ 580 NJ 580 NJ
preplace netloc processing_system7_0_axi_periph_M06_AXI 1 6 1 2190
preplace netloc processing_system7_0_DMA1_ACK 1 4 3 NJ 110 NJ 110 N
preplace netloc axi_vdma_1_M_AXIS_MM2S 1 2 5 660 1190 NJ 1190 NJ 1190 NJ 1190 NJ
preplace netloc axi_dispctrl_1_PXL_CLK_O 1 1 7 220 1200 NJ 1200 NJ 1200 NJ 1200 NJ 1200 2170 1390 2670
preplace netloc axi_dispctrl_0_GREEN_O 1 7 1 NJ
preplace netloc processing_system7_0_FIXED_IO 1 4 4 NJ 490 NJ 490 NJ 490 NJ
preplace netloc hdmi_tx_0_HDMI_CLK_N 1 7 1 NJ
preplace netloc axi_i2s_adi_1_LRCLK_O 1 7 1 2720
preplace netloc axi_dispctrl_1_FSYNC_O 1 1 7 190 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1170 NJ 1090 2680
preplace netloc axi_dispctrl_0_FSYNC_O 1 1 7 220 710 NJ 860 NJ 860 NJ 510 NJ 510 NJ 510 2670
preplace netloc S01_AXI_1 1 2 1 650
preplace netloc rst_processing_system7_0_97M_interconnect_aresetn 1 2 4 710 850 NJ 850 1510 790 1890
preplace netloc axi_i2s_adi_1_MUTEN_O 1 7 1 NJ
preplace netloc axi_dispctrl_1_VSYNC_O 1 6 2 2290 1560 2700
preplace netloc axi_dispctrl_1_RED_O 1 6 2 2250 1540 2660
preplace netloc axi_dispctrl_0_VSYNC_O 1 7 1 NJ
preplace netloc axi_dispctrl_0_HSYNC_O 1 7 1 NJ
preplace netloc myLED_0_led 1 7 1 NJ
preplace netloc processing_system7_0_FCLK_CLK0 1 1 6 200 720 NJ 770 1010 840 1540 640 1870 630 2280
preplace netloc hdmi_tx_0_HDMI_D0_N 1 7 1 NJ
preplace netloc hdmi_tx_0_HDMI_CLK_P 1 7 1 NJ
preplace netloc axi_vdma_1_m_axis_mm2s_tkeep 1 2 5 700 1210 NJ 1210 NJ 1210 NJ 1210 NJ
preplace netloc processing_system7_0_FCLK_CLK1 1 1 4 180 670 660 780 1020 790 1490
preplace netloc axi_i2s_adi_1_SDATA_O 1 7 1 NJ
preplace netloc axi_dispctrl_1_LOCKED_O 1 6 2 2260 1520 2690
preplace netloc SWs_4Bits_GPIO 1 7 1 NJ
preplace netloc processing_system7_0_axi_periph_M04_AXI 1 1 6 230 730 NJ 810 NJ 810 NJ 610 NJ 610 2170
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 6 1 2240
preplace netloc axi_i2s_adi_1_DMA_TX_REQ 1 3 5 1030 780 NJ 480 NJ 480 NJ 480 2690
preplace netloc processing_system7_0_FCLK_CLK2 1 4 4 NJ 130 NJ 130 2290 20 NJ
preplace netloc hdmi_tx_0_HDMI_D2_N 1 7 1 NJ
preplace netloc hdmi_tx_0_HDMI_D0_P 1 7 1 NJ
preplace netloc axi_i2s_adi_1_BCLK_O 1 7 1 NJ
preplace netloc axi_dispctrl_1_BLUE_O 1 6 2 2220 1500 2630
preplace netloc axi_dispctrl_0_RED_O 1 7 1 NJ
preplace netloc axi_dispctrl_0_BLUE_O 1 7 1 NJ
levelinfo -pg 1 0 90 430 850 1260 1730 2030 2460 2740 -top 0 -bot 1840
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


