#set_property -dict {PACKAGE_PIN U7}  [get_ports clk_buf_tp_n]
#set_property -dict {PACKAGE_PIN U8}  [get_ports clk_buf_tp_p]
set_property  -dict {PACKAGE_PIN AG17 IOSTANDARD LVCMOS18}  [get_ports dev_clk_out]
set_property  -dict {PACKAGE_PIN AG27 IOSTANDARD LVDS}  [get_ports dev_mcs_fpga_in_n]
set_property  -dict {PACKAGE_PIN AG26 IOSTANDARD LVDS}  [get_ports dev_mcs_fpga_in_p]

set_property  -dict {PACKAGE_PIN AF17 IOSTANDARD LVCMOS18}  [get_ports dgpio_0]
set_property  -dict {PACKAGE_PIN AH16 IOSTANDARD LVCMOS18}  [get_ports dgpio_1]
set_property  -dict {PACKAGE_PIN AF18 IOSTANDARD LVCMOS18}  [get_ports dgpio_2]
set_property  -dict {PACKAGE_PIN AH17 IOSTANDARD LVCMOS18}  [get_ports dgpio_3]
set_property  -dict {PACKAGE_PIN AH13 IOSTANDARD LVCMOS18}  [get_ports dgpio_4]
set_property  -dict {PACKAGE_PIN AK15 IOSTANDARD LVCMOS18}  [get_ports dgpio_5]
set_property  -dict {PACKAGE_PIN AH27 IOSTANDARD LVCMOS18}  [get_ports dgpio_6]
set_property  -dict {PACKAGE_PIN AJ26 IOSTANDARD LVCMOS18}  [get_ports dgpio_7]
set_property  -dict {PACKAGE_PIN AH26 IOSTANDARD LVCMOS18}  [get_ports dgpio_8]
set_property  -dict {PACKAGE_PIN AK16 IOSTANDARD LVCMOS18}  [get_ports dgpio_9]
set_property  -dict {PACKAGE_PIN AJ16 IOSTANDARD LVCMOS18}  [get_ports dgpio_10]
set_property  -dict {PACKAGE_PIN AC13 IOSTANDARD LVCMOS18}  [get_ports dgpio_11]

set_property  -dict {PACKAGE_PIN AA14 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports fpga_mcs_in_n]
set_property  -dict {PACKAGE_PIN AA15 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports fpga_mcs_in_p]
set_property  -dict {PACKAGE_PIN AD28 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports fpga_ref_clk_n]
set_property  -dict {PACKAGE_PIN AC28 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports fpga_ref_clk_p]
set_property  -dict {PACKAGE_PIN AC12 IOSTANDARD LVCMOS18}  [get_ports gp_int]
set_property  -dict {PACKAGE_PIN AE15 IOSTANDARD LVCMOS18}  [get_ports mode]
set_property  -dict {PACKAGE_PIN AE16 IOSTANDARD LVCMOS18}  [get_ports reset_trx]

set_property  -dict {PACKAGE_PIN AF13 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx1_dclk_out_n]
set_property  -dict {PACKAGE_PIN AE13 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx1_dclk_out_p]
set_property  -dict {PACKAGE_PIN AC14 IOSTANDARD LVCMOS18}  [get_ports rx1_enable]
set_property  -dict {PACKAGE_PIN AH12 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx1_idata_out_n]
set_property  -dict {PACKAGE_PIN AG12 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx1_idata_out_p]
set_property  -dict {PACKAGE_PIN AD13 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx1_qdata_out_n]
set_property  -dict {PACKAGE_PIN AD14 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx1_qdata_out_p]
set_property  -dict {PACKAGE_PIN AF12 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx1_strobe_out_n]
set_property  -dict {PACKAGE_PIN AE12 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx1_strobe_out_p]

set_property  -dict {PACKAGE_PIN AG15 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx2_dclk_out_n]
set_property  -dict {PACKAGE_PIN AF15 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx2_dclk_out_p]
set_property  -dict {PACKAGE_PIN AK26 IOSTANDARD LVCMOS18}  [get_ports rx2_enable]
set_property  -dict {PACKAGE_PIN AB14 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx2_idata_out_n]
set_property  -dict {PACKAGE_PIN AB15 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx2_idata_out_p]
set_property  -dict {PACKAGE_PIN AD15 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx2_qdata_out_n]
set_property  -dict {PACKAGE_PIN AD16 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx2_qdata_out_p]
set_property  -dict {PACKAGE_PIN AE17 IOSTANDARD LVDS DIFF_TERM TRUE} [get_ports rx2_strobe_out_n]
set_property  -dict {PACKAGE_PIN AE18 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports rx2_strobe_out_p]

set_property  -dict {PACKAGE_PIN AG16 IOSTANDARD LVCMOS18}  [get_ports sm_fan_tach]

set_property  -dict {PACKAGE_PIN AJ28 IOSTANDARD LVCMOS18}  [get_ports spi_clk]
set_property  -dict {PACKAGE_PIN AK28 IOSTANDARD LVCMOS18}  [get_ports spi_dio]
set_property  -dict {PACKAGE_PIN AH28 IOSTANDARD LVCMOS18}  [get_ports spi_do]
set_property  -dict {PACKAGE_PIN AH29 IOSTANDARD LVCMOS18}  [get_ports spi_en]

set_property  -dict {PACKAGE_PIN AA30 IOSTANDARD LVDS}  [get_ports tx1_dclk_in_n]
set_property  -dict {PACKAGE_PIN Y30 IOSTANDARD LVDS}  [get_ports tx1_dclk_in_p]
set_property  -dict {PACKAGE_PIN AC27 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports tx1_dclk_out_n]
set_property  -dict {PACKAGE_PIN AB27 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports tx1_dclk_out_p]
set_property  -dict {PACKAGE_PIN AH14 IOSTANDARD LVCMOS18}  [get_ports tx1_enable]
set_property  -dict {PACKAGE_PIN Y27 IOSTANDARD LVDS}  [get_ports tx1_idata_in_n]
set_property  -dict {PACKAGE_PIN Y26 IOSTANDARD LVDS}  [get_ports tx1_idata_in_p]
set_property  -dict {PACKAGE_PIN AB30 IOSTANDARD LVDS}  [get_ports tx1_qdata_in_n]
set_property  -dict {PACKAGE_PIN AB29 IOSTANDARD LVDS}  [get_ports tx1_qdata_in_p]
set_property  -dict {PACKAGE_PIN AD29 IOSTANDARD LVDS}  [get_ports tx1_strobe_in_n]
set_property  -dict {PACKAGE_PIN AC29 IOSTANDARD LVDS}  [get_ports tx1_strobe_in_p]

set_property  -dict {PACKAGE_PIN AG29 IOSTANDARD LVDS}  [get_ports tx2_dclk_in_n]
set_property  -dict {PACKAGE_PIN AF29 IOSTANDARD LVDS}  [get_ports tx2_dclk_in_p]
set_property  -dict {PACKAGE_PIN AF27 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports tx2_dclk_out_n]
set_property  -dict {PACKAGE_PIN AE27 IOSTANDARD LVDS DIFF_TERM TRUE}  [get_ports tx2_dclk_out_p]
set_property  -dict {PACKAGE_PIN AK27 IOSTANDARD LVCMOS18}  [get_ports tx2_enable]
set_property  -dict {PACKAGE_PIN AK30 IOSTANDARD LVDS}  [get_ports tx2_idata_in_n]
set_property  -dict {PACKAGE_PIN AJ30 IOSTANDARD LVDS}  [get_ports tx2_idata_in_p]
set_property  -dict {PACKAGE_PIN AG30 IOSTANDARD LVDS}  [get_ports tx2_qdata_in_n]
set_property  -dict {PACKAGE_PIN AF30 IOSTANDARD LVDS}  [get_ports tx2_qdata_in_p]
set_property  -dict {PACKAGE_PIN AF25 IOSTANDARD LVDS}  [get_ports tx2_strobe_in_n]
set_property  -dict {PACKAGE_PIN AE25 IOSTANDARD LVDS}  [get_ports tx2_strobe_in_p]

set_property  -dict {PACKAGE_PIN AJ15 IOSTANDARD LVCMOS18}  [get_ports vadj_test_1]
set_property  -dict {PACKAGE_PIN AD25 IOSTANDARD LVCMOS18}  [get_ports vadj_test_2]


# clocks

create_clock -name rx1_dclk_out   -period  2.00 [get_ports rx1_dclk_out_p]
create_clock -name rx2_dclk_out   -period  2.00 [get_ports rx2_dclk_out_p]
create_clock -name tx1_dclk_out   -period  2.00 [get_ports tx1_dclk_out_p]
create_clock -name tx2_dclk_out   -period  2.00 [get_ports tx2_dclk_out_p]

# set IOSTANDARD according to VADJ 1.8V

# hdmi

set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_out_clk]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_vsync]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_hsync]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data_e]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[0]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[1]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[2]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[3]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[4]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[5]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[6]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[7]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[8]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[9]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[10]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[11]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[12]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[13]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[14]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[15]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[16]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[17]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[18]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[19]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[20]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[21]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[22]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports hdmi_data[23]]

# spdif

set_property  -dict {IOSTANDARD LVCMOS18} [get_ports spdif]

# iic

set_property  -dict {IOSTANDARD LVCMOS18} [get_ports iic_scl]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports iic_sda]

# gpio (switches, leds and such)

set_property  -dict {IOSTANDARD LVCMOS18} [get_ports gpio_bd[0]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports gpio_bd[1]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports gpio_bd[2]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports gpio_bd[3]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports gpio_bd[4]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports gpio_bd[6]]

set_property  -dict {IOSTANDARD LVCMOS18} [get_ports gpio_bd[7]]
set_property  -dict {IOSTANDARD LVCMOS18} [get_ports gpio_bd[9]]
