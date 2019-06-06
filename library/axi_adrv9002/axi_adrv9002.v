// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module axi_adrv9002 #(

  parameter ID = 0,
  parameter IO_DELAY_GROUP = "dev_if_delay_group",

  parameter FPGA_TECHNOLOGY = 0,
  parameter FPGA_FAMILY = 0,
  parameter SPEED_GRADE = 0,
  parameter DEV_PACKAGE = 0) (

  // physical interface
  input                   rx1_dclk_in_n,
  input                   rx1_dclk_in_p,
  input                   rx1_idata_in_n,
  input                   rx1_idata_in_p,
  input                   rx1_qdata_in_n,
  input                   rx1_qdata_in_p,
  input                   rx1_strobe_in_n,
  input                   rx1_strobe_in_p,

  input                   rx2_dclk_in_n,
  input                   rx2_dclk_in_p,
  input                   rx2_idata_in_n,
  input                   rx2_idata_in_p,
  input                   rx2_qdata_in_n,
  input                   rx2_qdata_in_p,
  input                   rx2_strobe_in_n,
  input                   rx2_strobe_in_p,

  output                  tx1_dclk_out_n,
  output                  tx1_dclk_out_p,
  input                   tx1_dclk_in_n,
  input                   tx1_dclk_in_p,
  output                  tx1_idata_out_n,
  output                  tx1_idata_out_p,
  output                  tx1_qdata_out_n,
  output                  tx1_qdata_out_p,
  output                  tx1_strobe_out_n,
  output                  tx1_strobe_out_p,

  output                  tx2_dclk_out_n,
  output                  tx2_dclk_out_p,
  input                   tx2_dclk_in_n,
  input                   tx2_dclk_in_p,
  output                  tx2_idata_out_n,
  output                  tx2_idata_out_p,
  output                  tx2_qdata_out_n,
  output                  tx2_qdata_out_p,
  output                  tx2_strobe_out_n,
  output                  tx2_strobe_out_p,

  input                   delay_clk,

  // dma interface
  output                  adc_1_clk,
  output                  adc_1_enable,
  output                  adc_1_valid,
  output      [31:0]      adc_1_data,
  input                   adc_1_dovf,

  output                  adc_2_clk,
  output                  adc_2_enable,
  output                  adc_2_valid,
  output      [31:0]      adc_2_data,
  input                   adc_2_dovf,

  // axi interface
  input                   s_axi_aclk,
  input                   s_axi_aresetn,
  input                   s_axi_awvalid,
  input       [15:0]      s_axi_awaddr,
  output                  s_axi_awready,
  input                   s_axi_wvalid,
  input       [31:0]      s_axi_wdata,
  input       [ 3:0]      s_axi_wstrb,
  output                  s_axi_wready,
  output                  s_axi_bvalid,
  output      [ 1:0]      s_axi_bresp,
  input                   s_axi_bready,
  input                   s_axi_arvalid,
  input       [15:0]      s_axi_araddr,
  output                  s_axi_arready,
  output                  s_axi_rvalid,
  output      [ 1:0]      s_axi_rresp,
  output      [31:0]      s_axi_rdata,
  input                   s_axi_rready,
  input       [ 2:0]      s_axi_awprot,
  input       [ 2:0]      s_axi_arprot
);

  // internal signals
  wire            up_wreq_s;
  wire            up_rreq_s;
  wire    [13:0]  up_waddr_s;
  wire    [13:0]  up_raddr_s;
  wire    [31:0]  up_wdata_s;
  wire    [31:0]  up_rdata_s;
  wire            up_wack_s;
  wire            up_rack_s;

  wire    [2:0]   up_dld_s;
  wire    [14:0]  up_dwdata_s;
  wire    [14:0]  up_drdata_s;

  wire    [15:0]  rx1_data_i;
  wire    [15:0]  rx1_data_q;
  wire    [15:0]  rx2_data_i;
  wire    [15:0]  rx2_data_q;


  // internal clocks & resets
  wire            up_rstn;
  wire            up_clk;

  // clock/reset assignments
  assign up_clk  = s_axi_aclk;
  assign up_rstn = s_axi_aresetn;

  wire    [2:0]       up_rx1_dld;
  wire    [14:0]      up_rx1_dwdata;
  wire    [14:0]      up_rx1_drdata;
  wire    [2:0]       up_rx2_dld;
  wire    [14:0]      up_rx2_dwdata;
  wire    [14:0]      up_rx2_drdata;

  axi_adrv9002_if #(
    .FPGA_TECHNOLOGY (FPGA_TECHNOLOGY),
    .IO_DELAY_GROUP (IO_DELAY_GROUP))
  i_if(
    .rx1_dclk_in_n (rx1_dclk_in_n),
    .rx1_dclk_in_p (rx1_dclk_in_p),
    .rx1_idata_in_n (rx1_idata_in_n),
    .rx1_idata_in_p (rx1_idata_in_p),
    .rx1_qdata_in_n (rx1_qdata_in_n),
    .rx1_qdata_in_p (rx1_qdata_in_p),
    .rx1_strobe_in_n (rx1_strobe_in_n),
    .rx1_strobe_in_p (rx1_strobe_in_p),

    .rx2_dclk_in_n (rx2_dclk_in_n),
    .rx2_dclk_in_p (rx2_dclk_in_p),
    .rx2_idata_in_n (rx2_idata_in_n),
    .rx2_idata_in_p (rx2_idata_in_p),
    .rx2_qdata_in_n (rx2_qdata_in_n),
    .rx2_qdata_in_p (rx2_qdata_in_p),
    .rx2_strobe_in_n (rx2_strobe_in_n),
    .rx2_strobe_in_p (rx2_strobe_in_p),

    .tx1_dclk_out_n (tx1_dclk_out_n),
    .tx1_dclk_out_p (tx1_dclk_out_p),
    .tx1_dclk_in_n (tx1_dclk_in_n),
    .tx1_dclk_in_p (tx1_dclk_in_p),
    .tx1_idata_out_n (tx1_idata_out_n),
    .tx1_idata_out_p (tx1_idata_out_p),
    .tx1_qdata_out_n (tx1_qdata_out_n),
    .tx1_qdata_out_p (tx1_qdata_out_p),
    .tx1_strobe_out_n (tx1_strobe_out_n),
    .tx1_strobe_out_p (tx1_strobe_out_p),

    .tx2_dclk_out_n (tx2_dclk_out_n),
    .tx2_dclk_out_p (tx2_dclk_out_p),
    .tx2_dclk_in_n (tx2_dclk_in_n),
    .tx2_dclk_in_p (tx2_dclk_in_p),
    .tx2_idata_out_n (tx2_idata_out_n),
    .tx2_idata_out_p (tx2_idata_out_p),
    .tx2_qdata_out_n (tx2_qdata_out_n),
    .tx2_qdata_out_p (tx2_qdata_out_p),
    .tx2_strobe_out_n (tx2_strobe_out_n),
    .tx2_strobe_out_p (tx2_strobe_out_p),

    // delay interface (for IDELAY macros)
    .delay_clk (delay_clk),
    .delay_rx1_rst (delay_rx1_rst),
    .delay_rx2_rst (delay_rx2_rst),
    .delay_rx1_locked (delay_rx1_locked),
    .delay_rx2_locked (delay_rx2_locked),
    .up_clk (up_clk),
    .up_rx1_dld (up_rx1_dld),
    .up_rx1_dwdata (up_rx1_dwdata),
    .up_rx1_drdata (up_rx1_drdata),

    .up_rx2_dld (up_rx2_dld),
    .up_rx2_dwdata (up_rx2_dwdata),
    .up_rx2_drdata (up_rx2_drdata),

    // transport layer data interface
    .rx1_clk (adc_1_clk),
    .rx1_data_i (rx1_data_i),
    .rx1_data_q (rx1_data_q),

    .rx2_clk (adc_2_clk),
    .rx2_data_i (rx2_data_i),
    .rx2_data_q (rx2_data_q)
  );

  // common processor control
  axi_ad9002_core #(
    .ID (ID),
    .FPGA_TECHNOLOGY (FPGA_TECHNOLOGY),
    .FPGA_FAMILY (FPGA_FAMILY),
    .SPEED_GRADE (SPEED_GRADE),
    .DEV_PACKAGE (DEV_PACKAGE)
  ) i_core (
    // ADC interface
    .rx1_clk    (adc_1_clk),
    .rx1_data_i (rx1_data_i),
    .rx1_data_q (rx1_data_q),

    .rx2_clk    (adc_2_clk),
    .rx2_data_i (rx2_data_i),
    .rx2_data_q (rx2_data_q),

    // DMA interface
    .adc_1_enable (adc_1_enable),
    .adc_1_valid  (adc_1_valid ),
    .adc_1_data   (adc_1_data  ),
    .adc_1_dovf   (adc_1_dovf  ),

    .adc_2_enable (adc_2_enable),
    .adc_2_valid  (adc_2_valid ),
    .adc_2_data   (adc_2_data  ),
    .adc_2_dovf   (adc_2_dovf  ),

    .delay_clk (delay_clk),

    .up_rx1_dld (up_rx1_dld),
    .up_rx1_dwdata (up_rx1_dwdata),
    .up_rx1_drdata (up_rx1_drdata),
    .delay_rx1_rst (delay_rx1_rst),
    .delay_rx1_locked (delay_rx1_locked),

    .up_rx2_dld (up_rx2_dld),
    .up_rx2_dwdata (up_rx2_dwdata),
    .up_rx2_drdata (up_rx2_drdata),
    .delay_rx2_rst (delay_rx2_rst),
    .delay_rx2_locked (delay_rx2_locked),

    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_wreq (up_wreq_s),
    .up_waddr (up_waddr_s),
    .up_wdata (up_wdata_s),
    .up_wack (up_wack_s),
    .up_rreq (up_rreq_s),
    .up_raddr (up_raddr_s),
    .up_rdata (up_rdata_s),
    .up_rack (up_rack_s));

  // up bus interface
  up_axi i_up_axi (
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_axi_awvalid (s_axi_awvalid),
    .up_axi_awaddr (s_axi_awaddr),
    .up_axi_awready (s_axi_awready),
    .up_axi_wvalid (s_axi_wvalid),
    .up_axi_wdata (s_axi_wdata),
    .up_axi_wstrb (s_axi_wstrb),
    .up_axi_wready (s_axi_wready),
    .up_axi_bvalid (s_axi_bvalid),
    .up_axi_bresp (s_axi_bresp),
    .up_axi_bready (s_axi_bready),
    .up_axi_arvalid (s_axi_arvalid),
    .up_axi_araddr (s_axi_araddr),
    .up_axi_arready (s_axi_arready),
    .up_axi_rvalid (s_axi_rvalid),
    .up_axi_rresp (s_axi_rresp),
    .up_axi_rdata (s_axi_rdata),
    .up_axi_rready (s_axi_rready),
    .up_wreq (up_wreq_s),
    .up_waddr (up_waddr_s),
    .up_wdata (up_wdata_s),
    .up_rdata (up_rdata_s),
    .up_wack (up_wack_s),
    .up_raddr (up_raddr_s),
    .up_rreq (up_rreq_s),
    .up_rack (up_rack_s));

  endmodule
