-- (c) Copyright 1995-2016 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: Digilent:digilent:axi_dispctrl:1.0
-- IP Revision: 9

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT system_axi_dispctrl_0_0
  PORT (
    REF_CLK_I : IN STD_LOGIC;
    PXL_CLK_O : OUT STD_LOGIC;
    PXL_CLK_5X_O : OUT STD_LOGIC;
    LOCKED_O : OUT STD_LOGIC;
    FSYNC_O : OUT STD_LOGIC;
    HSYNC_O : OUT STD_LOGIC;
    VSYNC_O : OUT STD_LOGIC;
    DE_O : OUT STD_LOGIC;
    RED_O : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    GREEN_O : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    BLUE_O : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    DEBUG_O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC;
    s_axi_awready : OUT STD_LOGIC;
    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid : IN STD_LOGIC;
    s_axi_wready : OUT STD_LOGIC;
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC;
    s_axi_bready : IN STD_LOGIC;
    s_axi_araddr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC;
    s_axi_rready : IN STD_LOGIC;
    s_axis_mm2s_aclk : IN STD_LOGIC;
    s_axis_mm2s_aresetn : IN STD_LOGIC;
    s_axis_mm2s_tready : OUT STD_LOGIC;
    s_axis_mm2s_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_mm2s_tstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axis_mm2s_tlast : IN STD_LOGIC;
    s_axis_mm2s_tvalid : IN STD_LOGIC
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : system_axi_dispctrl_0_0
  PORT MAP (
    REF_CLK_I => REF_CLK_I,
    PXL_CLK_O => PXL_CLK_O,
    PXL_CLK_5X_O => PXL_CLK_5X_O,
    LOCKED_O => LOCKED_O,
    FSYNC_O => FSYNC_O,
    HSYNC_O => HSYNC_O,
    VSYNC_O => VSYNC_O,
    DE_O => DE_O,
    RED_O => RED_O,
    GREEN_O => GREEN_O,
    BLUE_O => BLUE_O,
    DEBUG_O => DEBUG_O,
    s_axi_aclk => s_axi_aclk,
    s_axi_aresetn => s_axi_aresetn,
    s_axi_awaddr => s_axi_awaddr,
    s_axi_awprot => s_axi_awprot,
    s_axi_awvalid => s_axi_awvalid,
    s_axi_awready => s_axi_awready,
    s_axi_wdata => s_axi_wdata,
    s_axi_wstrb => s_axi_wstrb,
    s_axi_wvalid => s_axi_wvalid,
    s_axi_wready => s_axi_wready,
    s_axi_bresp => s_axi_bresp,
    s_axi_bvalid => s_axi_bvalid,
    s_axi_bready => s_axi_bready,
    s_axi_araddr => s_axi_araddr,
    s_axi_arprot => s_axi_arprot,
    s_axi_arvalid => s_axi_arvalid,
    s_axi_arready => s_axi_arready,
    s_axi_rdata => s_axi_rdata,
    s_axi_rresp => s_axi_rresp,
    s_axi_rvalid => s_axi_rvalid,
    s_axi_rready => s_axi_rready,
    s_axis_mm2s_aclk => s_axis_mm2s_aclk,
    s_axis_mm2s_aresetn => s_axis_mm2s_aresetn,
    s_axis_mm2s_tready => s_axis_mm2s_tready,
    s_axis_mm2s_tdata => s_axis_mm2s_tdata,
    s_axis_mm2s_tstrb => s_axis_mm2s_tstrb,
    s_axis_mm2s_tlast => s_axis_mm2s_tlast,
    s_axis_mm2s_tvalid => s_axis_mm2s_tvalid
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

