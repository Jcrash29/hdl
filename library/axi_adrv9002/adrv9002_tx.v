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

module adrv9002_tx #(

  parameter FPGA_TECHNOLOGY = 0

) (

  // physical interface (transmit)
  output                  tx_dclk_out_n,
  output                  tx_dclk_out_p,
  input                   tx_dclk_in_n,
  input                   tx_dclk_in_p,
  output                  tx_idata_out_n,
  output                  tx_idata_out_p,
  output                  tx_qdata_out_n,
  output                  tx_qdata_out_p,
  output                  tx_strobe_out_n,
  output                  tx_strobe_out_p,

  // internal resets and clocks

  input                   dac_rst,
  output                  dac_clk,
  output                  dac_div_clk,   // div by 8

  input       [7:0]       dac_data_i,
  input       [7:0]       dac_data_q,
  input       [7:0]       dac_data_strb

);

  ad_serdes_out #(
    .DDR_OR_SDR_N(1),
    .DATA_WIDTH(1),
    .SERDES_FACTOR(8),
    .FPGA_TECHNOLOGY (FPGA_TECHNOLOGY))
  i_serdes_out_data_i (
    .rst (dac_rst),
    .clk (dac_clk),
    .div_clk (dac_div_clk),
    .loaden (1'b0),
    .data_s0 (dac_data_i[0]),
    .data_s1 (dac_data_i[1]),
    .data_s2 (dac_data_i[2]),
    .data_s3 (dac_data_i[3]),
    .data_s4 (dac_data_i[4]),
    .data_s5 (dac_data_i[5]),
    .data_s6 (dac_data_i[6]),
    .data_s7 (dac_data_i[7]),
    .data_out_se (),
    .data_out_p (tx_idata_out_p),
    .data_out_n (tx_idata_out_n));

  ad_serdes_out #(
    .DDR_OR_SDR_N(1),
    .DATA_WIDTH(1),
    .SERDES_FACTOR(8),
    .FPGA_TECHNOLOGY (FPGA_TECHNOLOGY))
  i_serdes_out_data_q (
    .rst (dac_rst),
    .clk (dac_clk),
    .div_clk (dac_div_clk),
    .loaden (1'b0),
    .data_s0 (dac_data_q[0]),
    .data_s1 (dac_data_q[1]),
    .data_s2 (dac_data_q[2]),
    .data_s3 (dac_data_q[3]),
    .data_s4 (dac_data_q[4]),
    .data_s5 (dac_data_q[5]),
    .data_s6 (dac_data_q[6]),
    .data_s7 (dac_data_q[7]),
    .data_out_se (),
    .data_out_p (tx_qdata_out_p),
    .data_out_n (tx_qdata_out_n));

  ad_serdes_out #(
    .DDR_OR_SDR_N(1),
    .DATA_WIDTH(1),
    .SERDES_FACTOR(8),
    .FPGA_TECHNOLOGY (FPGA_TECHNOLOGY))
  i_serdes_out_data_strobe (
    .rst (dac_rst),
    .clk (dac_clk),
    .div_clk (dac_div_clk),
    .loaden (1'b0),
    .data_s0 (dac_data_strb[0]),
    .data_s1 (dac_data_strb[1]),
    .data_s2 (dac_data_strb[2]),
    .data_s3 (dac_data_strb[3]),
    .data_s4 (dac_data_strb[4]),
    .data_s5 (dac_data_strb[5]),
    .data_s6 (dac_data_strb[6]),
    .data_s7 (dac_data_strb[7]),
    .data_out_se (),
    .data_out_p (tx_strobe_out_p),
    .data_out_n (tx_strobe_out_n));

  ad_serdes_out #(
    .DDR_OR_SDR_N(1),
    .DATA_WIDTH(1),
    .SERDES_FACTOR(8),
    .FPGA_TECHNOLOGY (FPGA_TECHNOLOGY))
  i_serdes_out_data_clk (
    .rst (dac_rst),
    .clk (dac_clk),
    .div_clk (dac_div_clk),
    .loaden (1'b0),
    .data_s0 (1'b1),
    .data_s1 (1'b0),
    .data_s2 (1'b1),
    .data_s3 (1'b0),
    .data_s4 (1'b1),
    .data_s5 (1'b0),
    .data_s6 (1'b1),
    .data_s7 (1'b0),
    .data_out_se (),
    .data_out_p (tx_dclk_out_p),
    .data_out_n (tx_dclk_out_n));

  // dac clock input buffers

  IBUFGDS i_dac_clk_in_ibuf (
    .I (tx_dclk_in_p),
    .IB (tx_dclk_in_n),
    .O (tx_dclk_in_s));

  BUFG i_dac_clk_in_gbuf (
    .I (tx_dclk_in_s),
    .O (dac_clk));

  BUFR #(.BUFR_DIVIDE("4")) i_dac_div_clk_rbuf (
    .CLR (1'b0),
    .CE (1'b1),
    .I (tx_dclk_in_s),
    .O (dac_div_clk_s));

  BUFG i_dac_div_clk_gbuf (
    .I (dac_div_clk_s),
    .O (dac_div_clk));


endmodule
