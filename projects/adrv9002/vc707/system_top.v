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

module system_top (
  input                   sys_rst,
  input                   sys_clk_p,
  input                   sys_clk_n,

  input                   uart_sin,
  output                  uart_sout,

  output      [13:0]      ddr3_addr,
  output      [ 2:0]      ddr3_ba,
  output                  ddr3_cas_n,
  output      [ 0:0]      ddr3_ck_n,
  output      [ 0:0]      ddr3_ck_p,
  output      [ 0:0]      ddr3_cke,
  output      [ 0:0]      ddr3_cs_n,
  output      [ 7:0]      ddr3_dm,
  inout       [63:0]      ddr3_dq,
  inout       [ 7:0]      ddr3_dqs_n,
  inout       [ 7:0]      ddr3_dqs_p,
  output      [ 0:0]      ddr3_odt,
  output                  ddr3_ras_n,
  output                  ddr3_reset_n,
  output                  ddr3_we_n,

  output      [26:1]      linear_flash_addr,
  output                  linear_flash_adv_ldn,
  output                  linear_flash_ce_n,
  output                  linear_flash_oen,
  output                  linear_flash_wen,
  inout       [15:0]      linear_flash_dq_io,

  input                   sgmii_rxp,
  input                   sgmii_rxn,
  output                  sgmii_txp,
  output                  sgmii_txn,

  output                  phy_rstn,
  input                   mgt_clk_p,
  input                   mgt_clk_n,
  output                  mdio_mdc,
  inout                   mdio_mdio,

  output                  fan_pwm,

  inout       [ 6:0]      gpio_lcd,
  inout       [20:0]      gpio_bd,

  output                  iic_rstn,
  inout                   iic_scl,
  inout                   iic_sda,

  output                  spi_clk,
  output                  spi_dio,
  input                   spi_do,
  output                  spi_en,

  // Device clock
  input                   fpga_ref_clk_n,
  input                   fpga_ref_clk_p,
  // Device clock passed through 9002
  input                   dev_clk_out,

  input                   fpga_mcs_in_n,
  input                   fpga_mcs_in_p,
  output                  dev_mcs_fpga_in_n,
  output                  dev_mcs_fpga_in_p,

  inout                   dgpio_0,
  inout                   dgpio_1,
  inout                   dgpio_2,
  inout                   dgpio_3,
  inout                   dgpio_4,
  inout                   dgpio_5,
  inout                   dgpio_6,
  inout                   dgpio_7,
  inout                   dgpio_8,
  inout                   dgpio_9,
  inout                   dgpio_10,
  inout                   dgpio_11,

  inout                   gp_int,
  inout                   mode,
  inout                   reset_trx,

  input                   rx1_dclk_out_n,
  input                   rx1_dclk_out_p,
  output                  rx1_enable,
  input                   rx1_idata_out_n,
  input                   rx1_idata_out_p,
  input                   rx1_qdata_out_n,
  input                   rx1_qdata_out_p,
  input                   rx1_strobe_out_n,
  input                   rx1_strobe_out_p,

  input                   rx2_dclk_out_n,
  input                   rx2_dclk_out_p,
  output                  rx2_enable,
  input                   rx2_idata_out_n,
  input                   rx2_idata_out_p,
  input                   rx2_qdata_out_n,
  input                   rx2_qdata_out_p,
  input                   rx2_strobe_out_n,
  input                   rx2_strobe_out_p,

  output                  tx1_dclk_in_n,
  output                  tx1_dclk_in_p,
  input                   tx1_dclk_out_n,
  input                   tx1_dclk_out_p,
  output                  tx1_enable,
  output                  tx1_idata_in_n,
  output                  tx1_idata_in_p,
  output                  tx1_qdata_in_n,
  output                  tx1_qdata_in_p,
  output                  tx1_strobe_in_n,
  output                  tx1_strobe_in_p,

  output                  tx2_dclk_in_n,
  output                  tx2_dclk_in_p,
  input                   tx2_dclk_out_n,
  input                   tx2_dclk_out_p,
  output                  tx2_enable,
  output                  tx2_idata_in_n,
  output                  tx2_idata_in_p,
  output                  tx2_qdata_in_n,
  output                  tx2_qdata_in_p,
  output                  tx2_strobe_in_n,
  output                  tx2_strobe_in_p,

  inout                   sm_fan_tach,
  inout                   vadj_test_1,
  inout                   vadj_test_2
);

  // internal signals
  wire        [94:0]      gpio_i;
  wire        [94:0]      gpio_o;
  wire        [94:0]      gpio_t;
  wire        [ 2:0]      spi_csn;

  wire fpga_ref_clk;
  wire fpga_mcs_in;
  reg dev_mcs_fpga_in;

  assign gpio_i[94:54] = gpio_o[94:54];
  assign gpio_i[31:21] = gpio_o[31:21];


  // instantiations


  IBUFDS i_ibufgs_fpga_ref_clk (
    .I (fpga_ref_clk_p),
    .IB (fpga_ref_clk_n),
    .O (fpga_ref_clk));

  IBUFDS i_ibufgs_fpga_mcs_in (
    .I (fpga_mcs_in_p),
    .IB (fpga_mcs_in_n),
    .O (fpga_mcs_in));

  OBUFDS i_obufds_dev_mcs_fpga_in (
    .I (dev_mcs_fpga_in),
    .O (dev_mcs_fpga_in_p),
    .OB (dev_mcs_fpga_in_n));

  // Loopback MCS
  always @(posedge fpga_ref_clk)
    dev_mcs_fpga_in <= fpga_mcs_in;

  ad_iobuf #(.DATA_WIDTH(22)) i_iobuf (
    .dio_t ({gpio_t[53:32]}),
    .dio_i ({gpio_o[53:32]}),
    .dio_o ({gpio_i[53:32]}),
    .dio_p ({vadj_test_2,
             vadj_test_1,
             tx2_enable,
             tx1_enable,
             rx2_enable,
             rx1_enable,
             sm_fan_tach,
             reset_trx,
             mode,
             gp_int,
             dgpio_11,
             dgpio_10,
             dgpio_9,
             dgpio_8,
             dgpio_7,
             dgpio_6,
             dgpio_5,
             dgpio_4,
             dgpio_3,
             dgpio_2,
             dgpio_1,
             dgpio_0 }));  // 32

  ad_iobuf #(.DATA_WIDTH(21)) i_iobuf_sw_led (
    .dio_t (gpio_t[20:0]),
    .dio_i (gpio_o[20:0]),
    .dio_o (gpio_i[20:0]),
    .dio_p (gpio_bd));

  // default logic

  assign fan_pwm = 1'b1;
  assign iic_rstn = 1'b1;
  assign spi_en = spi_csn[0];

  system_wrapper i_system_wrapper (
    .ddr3_addr (ddr3_addr),
    .ddr3_ba (ddr3_ba),
    .ddr3_cas_n (ddr3_cas_n),
    .ddr3_ck_n (ddr3_ck_n),
    .ddr3_ck_p (ddr3_ck_p),
    .ddr3_cke (ddr3_cke),
    .ddr3_cs_n (ddr3_cs_n),
    .ddr3_dm (ddr3_dm),
    .ddr3_dq (ddr3_dq),
    .ddr3_dqs_n (ddr3_dqs_n),
    .ddr3_dqs_p (ddr3_dqs_p),
    .ddr3_odt (ddr3_odt),
    .ddr3_ras_n (ddr3_ras_n),
    .ddr3_reset_n (ddr3_reset_n),
    .ddr3_we_n (ddr3_we_n),
    .linear_flash_addr (linear_flash_addr),
    .linear_flash_adv_ldn (linear_flash_adv_ldn),
    .linear_flash_ce_n (linear_flash_ce_n),
    .linear_flash_oen (linear_flash_oen),
    .linear_flash_wen (linear_flash_wen),
    .linear_flash_dq_io(linear_flash_dq_io),
    .gpio_lcd_tri_io (gpio_lcd),
    .gpio0_o (gpio_o[31:0]),
    .gpio0_t (gpio_t[31:0]),
    .gpio0_i (gpio_i[31:0]),
    .gpio1_o (gpio_o[63:32]),
    .gpio1_t (gpio_t[63:32]),
    .gpio1_i (gpio_i[63:32]),
    .iic_main_scl_io (iic_scl),
    .iic_main_sda_io (iic_sda),
    .mdio_mdc (mdio_mdc),
    .mdio_mdio_io (mdio_mdio),
    .mgt_clk_clk_n (mgt_clk_n),
    .mgt_clk_clk_p (mgt_clk_p),
    .phy_rstn (phy_rstn),
    .phy_sd (1'b1),
    .sgmii_rxn (sgmii_rxn),
    .sgmii_rxp (sgmii_rxp),
    .sgmii_txn (sgmii_txn),
    .sgmii_txp (sgmii_txp),
    .sys_clk_n (sys_clk_n),
    .sys_clk_p (sys_clk_p),
    .sys_rst (sys_rst),
    .spi_clk_i (spi_clk),
    .spi_clk_o (spi_clk),
    .spi_csn_i (spi_csn),
    .spi_csn_o (spi_csn),
    .spi_sdi_i (spi_miso),
    .spi_sdo_i (spi_mosi),
    .spi_sdo_o (spi_mosi),

    .rx1_dclk_in_n (rx1_dclk_out_n),
    .rx1_dclk_in_p (rx1_dclk_out_p),
    .rx1_idata_in_n (rx1_idata_out_n),
    .rx1_idata_in_p (rx1_idata_out_p),
    .rx1_qdata_in_n (rx1_qdata_out_n),
    .rx1_qdata_in_p (rx1_qdata_out_p),
    .rx1_strobe_in_n (rx1_strobe_out_n),
    .rx1_strobe_in_p (rx1_strobe_out_p),

    .rx2_dclk_in_n (rx2_dclk_out_n),
    .rx2_dclk_in_p (rx2_dclk_out_p),
    .rx2_idata_in_n (rx2_idata_out_n),
    .rx2_idata_in_p (rx2_idata_out_p),
    .rx2_qdata_in_n (rx2_qdata_out_n),
    .rx2_qdata_in_p (rx2_qdata_out_p),
    .rx2_strobe_in_n (rx2_strobe_out_n),
    .rx2_strobe_in_p (rx2_strobe_out_p),

    .tx1_dclk_out_n (tx1_dclk_in_n),
    .tx1_dclk_out_p (tx1_dclk_in_p),
    .tx1_dclk_in_n (tx1_dclk_out_n),
    .tx1_dclk_in_p (tx1_dclk_out_p),
    .tx1_idata_out_n (tx1_idata_in_n),
    .tx1_idata_out_p (tx1_idata_in_p),
    .tx1_qdata_out_n (tx1_qdata_in_n),
    .tx1_qdata_out_p (tx1_qdata_in_p),
    .tx1_strobe_out_n (tx1_strobe_in_n),
    .tx1_strobe_out_p (tx1_strobe_in_p),

    .tx2_dclk_out_n (tx2_dclk_in_n),
    .tx2_dclk_out_p (tx2_dclk_in_p),
    .tx2_dclk_in_n (tx2_dclk_out_n),
    .tx2_dclk_in_p (tx2_dclk_out_p),
    .tx2_idata_out_n (tx2_idata_in_n),
    .tx2_idata_out_p (tx2_idata_in_p),
    .tx2_qdata_out_n (tx2_qdata_in_n),
    .tx2_qdata_out_p (tx2_qdata_in_p),
    .tx2_strobe_out_n (tx2_strobe_in_n),
    .tx2_strobe_out_p (tx2_strobe_in_p)
  );
endmodule

// ***************************************************************************
// ***************************************************************************
