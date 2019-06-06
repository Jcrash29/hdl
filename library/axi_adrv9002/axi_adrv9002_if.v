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

module axi_adrv9002_if #(

  parameter FPGA_TECHNOLOGY = 0,
  parameter IO_DELAY_GROUP = "dev_if_delay_group"

) (

  // device interface
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

  // delay interface (for IDELAY macros)
  input                   delay_clk,
  input                   delay_rx1_rst,
  input                   delay_rx2_rst,
  output                  delay_rx1_locked,
  output                  delay_rx2_locked,

  input                   up_clk,
  input       [2:0]       up_rx1_dld,
  input       [14:0]      up_rx1_dwdata,
  output      [14:0]      up_rx1_drdata,

  input       [2:0]       up_rx2_dld,
  input       [14:0]      up_rx2_dwdata,
  output      [14:0]      up_rx2_drdata,


  // upper layer data interface
  output                  rx1_clk,
  output  reg [15:0]      rx1_data_i,
  output  reg [15:0]      rx1_data_q,

  output                  rx2_clk,
  output  reg [15:0]      rx2_data_i,
  output  reg [15:0]      rx2_data_q

);

  wire  [7:0] adc_1_data_i;
  wire  [7:0] adc_1_data_q;
  wire  [7:0] adc_1_data_strobe;

  wire  [7:0] adc_2_data_i;
  wire  [7:0] adc_2_data_q;
  wire  [7:0] adc_2_data_strobe;

  adrv9002_rx
    #(.FPGA_TECHNOLOGY(FPGA_TECHNOLOGY),
      .IODELAY_CTRL(1),
      .IO_DELAY_GROUP ({IO_DELAY_GROUP,"_rx"})
    ) rx1 (
    .rx_dclk_in_n (rx1_dclk_in_n),
    .rx_dclk_in_p (rx1_dclk_in_p),
    .rx_idata_in_n (rx1_idata_in_n),
    .rx_idata_in_p (rx1_idata_in_p),
    .rx_qdata_in_n (rx1_qdata_in_n),
    .rx_qdata_in_p (rx1_qdata_in_p),
    .rx_strobe_in_n (rx1_strobe_in_n),
    .rx_strobe_in_p (rx1_strobe_in_p),

    .adc_clk (adc_1_clk),
    .adc_rst (adc_rst),
    .adc_data_i (adc_1_data_i),
    .adc_data_q (adc_1_data_q),
    .adc_data_strobe (adc_1_data_strobe),

    .up_clk (up_clk),
    .up_adc_dld (up_rx1_dld),
    .up_adc_dwdata (up_rx1_dwdata),
    .up_adc_drdata (up_rx1_drdata),
    .delay_clk (delay_clk),
    .delay_rst (delay_rx1_rst),
    .delay_locked (delay_1_locked)
  );

  adrv9002_rx
    #(.FPGA_TECHNOLOGY(FPGA_TECHNOLOGY),
      .IODELAY_CTRL(0),
      .IO_DELAY_GROUP ({IO_DELAY_GROUP,"_rx"})
    ) rx2 (
    .rx_dclk_in_n (rx2_dclk_in_n),
    .rx_dclk_in_p (rx2_dclk_in_p),
    .rx_idata_in_n (rx2_idata_in_n),
    .rx_idata_in_p (rx2_idata_in_p),
    .rx_qdata_in_n (rx2_qdata_in_n),
    .rx_qdata_in_p (rx2_qdata_in_p),
    .rx_strobe_in_n (rx2_strobe_in_n),
    .rx_strobe_in_p (rx2_strobe_in_p),

    .adc_clk (adc_2_clk),
    .adc_rst (adc_rst),
    .adc_data_i (adc_2_data_i),
    .adc_data_q (adc_2_data_q),
    .adc_data_strobe (adc_2_data_strobe),

    .up_clk (up_clk),
    .up_adc_dld (up_rx2_dld),
    .up_adc_dwdata (up_rx2_dwdata),
    .up_adc_drdata (up_rx2_drdata),
    .delay_clk (delay_clk),
    .delay_rst (delay_rx2_rst),
    .delay_locked (delay_2_locked)
  );

  // TODO ; change it with proper gearbox
  assign rx1_clk = adc_1_clk;
  always @(posedge rx1_clk) begin
    if (|adc_1_data_strobe) begin
      rx1_data_i <= {rx1_data_i[7:0], adc_1_data_i};
      rx1_data_q <= {rx1_data_q[7:0], adc_1_data_q};
    end
  end
  assign rx2_clk = adc_2_clk;
  always @(posedge rx2_clk) begin
    if (|adc_2_data_strobe) begin
      rx2_data_i <= {rx2_data_i[7:0], adc_2_data_i};
      rx2_data_q <= {rx2_data_q[7:0], adc_2_data_q};
    end
  end

endmodule

