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

module axi_ad9002_core #(

  parameter ID = 0,
  parameter FPGA_TECHNOLOGY = 0,
  parameter FPGA_FAMILY = 0,
  parameter SPEED_GRADE = 0,
  parameter DEV_PACKAGE = 0) (

  // ADC interface
  input             rx1_clk,
  input [15:0]      rx1_data_i,
  input [15:0]      rx1_data_q,

  input             rx2_clk,
  input [15:0]      rx2_data_i,
  input [15:0]      rx2_data_q,

  // DAC interface
  input                    tx1_clk,
  output       [15:0]      tx1_data_i,
  output       [15:0]      tx1_data_q,

  input                    tx2_clk,
  output       [15:0]      tx2_data_i,
  output       [15:0]      tx2_data_q,

  // DMA interface
  output                  adc_1_enable,
  output                  adc_1_valid,
  output      [31:0]      adc_1_data,
  input                   adc_1_dovf,

  output                  adc_2_enable,
  output                  adc_2_valid,
  output      [31:0]      adc_2_data,
  input                   adc_2_dovf,

  output                  dac_1_valid,
  output                  dac_1_enable,
  input       [31:0]      dac_1_data,
  input                   dac_1_dunf,

  output                  dac_2_valid,
  output                  dac_2_enable,
  input       [31:0]      dac_2_data,
  input                   dac_2_dunf,
  // delay interface

  input                   delay_clk,

  output      [2:0]       up_rx1_dld,
  output      [14:0]      up_rx1_dwdata,
  input       [14:0]      up_rx1_drdata,
  output                  delay_rx1_rst,
  input                   delay_rx1_locked,

  output      [2:0]       up_rx2_dld,
  output      [14:0]      up_rx2_dwdata,
  input       [14:0]      up_rx2_drdata,
  output                  delay_rx2_rst,
  input                   delay_rx2_locked,
  // processor interface

  input                   up_rstn,
  input                   up_clk,
  input                   up_wreq,
  input       [13:0]      up_waddr,
  input       [31:0]      up_wdata,
  output  reg             up_wack,
  input                   up_rreq,
  input       [13:0]      up_raddr,
  output  reg [31:0]      up_rdata,
  output  reg             up_rack
);

  wire            up_wack_s[0:3];
  wire    [31:0]  up_rdata_s[0:3];
  wire            up_rack_s[0:3];



  // TODO  add PN, data formater
  assign adc_1_enable = 1'b1;
  assign adc_1_valid = 1'b1;
  assign adc_1_data = {rx1_data_q,rx1_data_i};

  assign adc_2_enable = 1'b1;
  assign adc_2_valid = 1'b1;
  assign adc_2_data = {rx2_data_q,rx2_data_i};


  // TODO  add DAC specific blocks 
  assign {tx1_data_q,tx1_data_i} = dac_1_data;
  assign {tx2_data_q,tx2_data_i} = dac_2_data;
  assign dac_1_valid = 1'b1;
  assign dac_2_valid = 1'b1;
  assign dac_1_enable = 1'b1;
  assign dac_2_enable = 1'b1;

  // processor read interface

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_rdata <= 'd0;
      up_rack <= 'd0;
      up_wack <= 'd0;
    end else begin
      up_rdata <= up_rdata_s[0] | up_rdata_s[1] | up_rdata_s[2] | up_rdata_s[3] ;
      up_rack  <= up_rack_s[0]  | up_rack_s[1]  | up_rack_s[2]  | up_rack_s[3]  ;
      up_wack  <= up_wack_s[0]  | up_wack_s[1]  | up_wack_s[2]  | up_wack_s[3]  ;
    end
  end


  // adc delay control
  up_delay_cntrl #(.DATA_WIDTH(3), .BASE_ADDRESS(6'h02)) i_delay_cntrl_rx1 (
    .delay_clk (delay_clk),
    .delay_rst (delay_rx1_rst),
    .delay_locked (delay_rx1_locked),
    .up_dld (up_rx1_dld),
    .up_dwdata (up_rx1_dwdata),
    .up_drdata (up_rx1_drdata),
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_wreq (up_wreq),
    .up_waddr (up_waddr),
    .up_wdata (up_wdata),
    .up_wack (up_wack_s[2]),
    .up_rreq (up_rreq),
    .up_raddr (up_raddr),
    .up_rdata (up_rdata_s[2]),
    .up_rack (up_rack_s[2]));

  up_delay_cntrl #(.DATA_WIDTH(3), .BASE_ADDRESS(6'h03)) i_delay_cntrl_rx2 (
    .delay_clk (delay_clk),
    .delay_rst (delay_rx2_rst),
    .delay_locked (delay_rx2_locked),
    .up_dld (up_rx2_dld),
    .up_dwdata (up_rx2_dwdata),
    .up_drdata (up_rx2_drdata),
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_wreq (up_wreq),
    .up_waddr (up_waddr),
    .up_wdata (up_wdata),
    .up_wack (up_wack_s[3]),
    .up_rreq (up_rreq),
    .up_raddr (up_raddr),
    .up_rdata (up_rdata_s[3]),
    .up_rack (up_rack_s[3]));



endmodule

