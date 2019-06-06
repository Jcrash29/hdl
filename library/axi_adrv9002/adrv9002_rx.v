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

module adrv9002_rx #(

  parameter FPGA_TECHNOLOGY = 0,
  parameter IODELAY_CTRL = 0,
  parameter IO_DELAY_GROUP = "dev_if_delay_group"

) (

  // device interface
  input                   rx_dclk_in_n,
  input                   rx_dclk_in_p,
  input                   rx_idata_in_n,
  input                   rx_idata_in_p,
  input                   rx_qdata_in_n,
  input                   rx_qdata_in_p,
  input                   rx_strobe_in_n,
  input                   rx_strobe_in_p,

  // internal reset and clocks
  output                  adc_clk,
  input                   adc_rst,
  output      [7:0]       adc_data_i,
  output      [7:0]       adc_data_q,
  output      [7:0]       adc_data_strobe,

  // delay interface (for IDELAY macros)
  input                   up_clk,
  input       [2:0]       up_adc_dld,
  input       [14:0]      up_adc_dwdata,
  output      [14:0]      up_adc_drdata,
  input                   delay_clk,
  input                   delay_rst,
  output                  delay_locked

);

  localparam SERDES_OR_DDR_N = 1;
  localparam MMCM_OR_BUFIO_N = 0;

  localparam DDR_OR_SDR_N = 1;

  // internal registers

  reg adc_status_m1 = 'd0;
  wire adc_div_clk;

  // output assignment for adc clock (1:8 of the sampling clock)
  assign adc_clk = adc_div_clk;

  // data interface
  ad_serdes_in #(
    .FPGA_TECHNOLOGY (FPGA_TECHNOLOGY),
    .IODELAY_CTRL (IODELAY_CTRL),
    .IODELAY_GROUP (IO_DELAY_GROUP),
    .DDR_OR_SDR_N (DDR_OR_SDR_N),
    .DATA_WIDTH (3),
    .SERDES_FACTOR (8))
  i_adc_data_i (
    .rst (adc_rst),
    .clk (adc_clk_in),
    .div_clk (adc_div_clk),
    .loaden (1'b0),
    .phase (8'b0),
    .locked (1'b0),
    .data_s0 ({adc_data_strobe[7],adc_data_q[7],adc_data_i[7]}),
    .data_s1 ({adc_data_strobe[6],adc_data_q[6],adc_data_i[6]}),
    .data_s2 ({adc_data_strobe[5],adc_data_q[5],adc_data_i[5]}),
    .data_s3 ({adc_data_strobe[4],adc_data_q[4],adc_data_i[4]}),
    .data_s4 ({adc_data_strobe[3],adc_data_q[3],adc_data_i[3]}),
    .data_s5 ({adc_data_strobe[2],adc_data_q[2],adc_data_i[2]}),
    .data_s6 ({adc_data_strobe[1],adc_data_q[1],adc_data_i[1]}),
    .data_s7 ({adc_data_strobe[0],adc_data_q[0],adc_data_i[0]}),
    .data_in_p ({rx_strobe_in_p,rx_qdata_in_p,rx_idata_in_p}),
    .data_in_n ({rx_strobe_in_n,rx_qdata_in_n,rx_idata_in_n}),
    .up_clk (up_clk),
    .up_dld (up_adc_dld),
    .up_dwdata (up_adc_dwdata[14:0]),
    .up_drdata (up_adc_drdata[14:0]),
    .delay_clk (delay_clk),
    .delay_rst (delay_rst),
    .delay_locked (delay_locked));


 ad_serdes_clk #(
    .DDR_OR_SDR_N (SERDES_OR_DDR_N),
    .MMCM_OR_BUFR_N (MMCM_OR_BUFIO_N),
    .FPGA_TECHNOLOGY (FPGA_TECHNOLOGY))
  i_serdes_clk (
    .rst (),
    .clk_in_p (rx_dclk_in_p),
    .clk_in_n (rx_dclk_in_n),
    .clk (adc_clk_in),
    .div_clk (adc_div_clk),
    .out_clk (),
    .loaden (),
    .phase ());


endmodule
