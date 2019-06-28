
source $ad_hdl_dir/projects/common/zcu102/zcu102_system_bd.tcl

#system ID
ad_ip_parameter axi_sysid_0 CONFIG.ROM_ADDR_BITS 9
ad_ip_parameter rom_sys_0 CONFIG.PATH_TO_FILE "[pwd]/mem_init_sys.txt"
ad_ip_parameter rom_sys_0 CONFIG.ROM_ADDR_BITS 9
set sys_cstring "sys rom custom string placeholder"
sysid_gen_sys_init_file $sys_cstring

ad_ip_parameter sys_ps8 CONFIG.PSU__FPGA_PL2_ENABLE 1
ad_ip_parameter sys_ps8 CONFIG.PSU__CRL_APB__PL2_REF_CTRL__FREQMHZ 200
ad_ip_parameter sys_ps8 CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR0 3
ad_ip_parameter sys_ps8 CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR1 2
ad_connect  sys_dma_clk sys_ps8/pl_clk2
source ../common/fmcomms5_bd.tcl

ad_ip_parameter axi_ad9361_0 CONFIG.ADC_INIT_DELAY 8
ad_ip_parameter axi_ad9361_0 CONFIG.DELAY_REFCLK_FREQUENCY 500
ad_ip_parameter axi_ad9361_1 CONFIG.ADC_INIT_DELAY 8
ad_ip_parameter axi_ad9361_1 CONFIG.DELAY_REFCLK_FREQUENCY 500

ad_ip_parameter util_ad9361_divclk CONFIG.SIM_DEVICE ULTRASCALE
