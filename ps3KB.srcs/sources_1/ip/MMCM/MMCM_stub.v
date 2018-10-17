// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sat Oct 13 19:53:37 2018
// Host        : LAPTOP-RQ9HGJT6 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top MMCM -prefix
//               MMCM_ clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module MMCM(CLK_OUT_25, CLK_OUT_100, reset, locked, 
  CLK_IN_100)
/* synthesis syn_black_box black_box_pad_pin="CLK_OUT_25,CLK_OUT_100,reset,locked,CLK_IN_100" */;
  output CLK_OUT_25;
  output CLK_OUT_100;
  input reset;
  output locked;
  input CLK_IN_100;
endmodule
