# adrv9002 interface
create_bd_port -dir I rx1_dclk_in_n
create_bd_port -dir I rx1_dclk_in_p
create_bd_port -dir I rx1_idata_in_n
create_bd_port -dir I rx1_idata_in_p
create_bd_port -dir I rx1_qdata_in_n
create_bd_port -dir I rx1_qdata_in_p
create_bd_port -dir I rx1_strobe_in_n
create_bd_port -dir I rx1_strobe_in_p

create_bd_port -dir I rx2_dclk_in_n
create_bd_port -dir I rx2_dclk_in_p
create_bd_port -dir I rx2_idata_in_n
create_bd_port -dir I rx2_idata_in_p
create_bd_port -dir I rx2_qdata_in_n
create_bd_port -dir I rx2_qdata_in_p
create_bd_port -dir I rx2_strobe_in_n
create_bd_port -dir I rx2_strobe_in_p

create_bd_port -dir O tx1_dclk_out_n
create_bd_port -dir O tx1_dclk_out_p
create_bd_port -dir I tx1_dclk_in_n
create_bd_port -dir I tx1_dclk_in_p
create_bd_port -dir O tx1_idata_out_n
create_bd_port -dir O tx1_idata_out_p
create_bd_port -dir O tx1_qdata_out_n
create_bd_port -dir O tx1_qdata_out_p
create_bd_port -dir O tx1_strobe_out_n
create_bd_port -dir O tx1_strobe_out_p

create_bd_port -dir O tx2_dclk_out_n
create_bd_port -dir O tx2_dclk_out_p
create_bd_port -dir I tx2_dclk_in_n
create_bd_port -dir I tx2_dclk_in_p
create_bd_port -dir O tx2_idata_out_n
create_bd_port -dir O tx2_idata_out_p
create_bd_port -dir O tx2_qdata_out_n
create_bd_port -dir O tx2_qdata_out_p
create_bd_port -dir O tx2_strobe_out_n
create_bd_port -dir O tx2_strobe_out_p

# adrv9002

ad_ip_instance axi_adrv9002 axi_adrv9002

# dma for rx1

ad_ip_instance axi_dmac axi_adrv9002_rx1_dma
ad_ip_parameter axi_adrv9002_rx1_dma CONFIG.DMA_TYPE_SRC 2
ad_ip_parameter axi_adrv9002_rx1_dma CONFIG.DMA_TYPE_DEST 0
ad_ip_parameter axi_adrv9002_rx1_dma CONFIG.CYCLIC 0
ad_ip_parameter axi_adrv9002_rx1_dma CONFIG.SYNC_TRANSFER_START 0
ad_ip_parameter axi_adrv9002_rx1_dma CONFIG.AXI_SLICE_SRC 0
ad_ip_parameter axi_adrv9002_rx1_dma CONFIG.AXI_SLICE_DEST 0
ad_ip_parameter axi_adrv9002_rx1_dma CONFIG.DMA_2D_TRANSFER 0
ad_ip_parameter axi_adrv9002_rx1_dma CONFIG.DMA_DATA_WIDTH_SRC 32

# dma for rx2

ad_ip_instance axi_dmac axi_adrv9002_rx2_dma
ad_ip_parameter axi_adrv9002_rx2_dma CONFIG.DMA_TYPE_SRC 2
ad_ip_parameter axi_adrv9002_rx2_dma CONFIG.DMA_TYPE_DEST 0
ad_ip_parameter axi_adrv9002_rx2_dma CONFIG.CYCLIC 0
ad_ip_parameter axi_adrv9002_rx2_dma CONFIG.SYNC_TRANSFER_START 0
ad_ip_parameter axi_adrv9002_rx2_dma CONFIG.AXI_SLICE_SRC 0
ad_ip_parameter axi_adrv9002_rx2_dma CONFIG.AXI_SLICE_DEST 0
ad_ip_parameter axi_adrv9002_rx2_dma CONFIG.DMA_2D_TRANSFER 0
ad_ip_parameter axi_adrv9002_rx2_dma CONFIG.DMA_DATA_WIDTH_SRC 32

# ad9434 connections

ad_connect  sys_200m_clk axi_adrv9002/delay_clk
ad_connect  axi_adrv9002/adc_1_clk axi_adrv9002_rx1_dma/fifo_wr_clk
ad_connect  axi_adrv9002/adc_2_clk axi_adrv9002_rx2_dma/fifo_wr_clk

ad_connect rx1_dclk_in_n     axi_adrv9002/rx1_dclk_in_n
ad_connect rx1_dclk_in_p     axi_adrv9002/rx1_dclk_in_p
ad_connect rx1_idata_in_n    axi_adrv9002/rx1_idata_in_n
ad_connect rx1_idata_in_p    axi_adrv9002/rx1_idata_in_p
ad_connect rx1_qdata_in_n    axi_adrv9002/rx1_qdata_in_n
ad_connect rx1_qdata_in_p    axi_adrv9002/rx1_qdata_in_p
ad_connect rx1_strobe_in_n   axi_adrv9002/rx1_strobe_in_n
ad_connect rx1_strobe_in_p   axi_adrv9002/rx1_strobe_in_p

ad_connect rx2_dclk_in_n     axi_adrv9002/rx2_dclk_in_n
ad_connect rx2_dclk_in_p     axi_adrv9002/rx2_dclk_in_p
ad_connect rx2_idata_in_n    axi_adrv9002/rx2_idata_in_n
ad_connect rx2_idata_in_p    axi_adrv9002/rx2_idata_in_p
ad_connect rx2_qdata_in_n    axi_adrv9002/rx2_qdata_in_n
ad_connect rx2_qdata_in_p    axi_adrv9002/rx2_qdata_in_p
ad_connect rx2_strobe_in_n   axi_adrv9002/rx2_strobe_in_n
ad_connect rx2_strobe_in_p   axi_adrv9002/rx2_strobe_in_p

ad_connect tx1_dclk_out_n    axi_adrv9002/tx1_dclk_out_n
ad_connect tx1_dclk_out_p    axi_adrv9002/tx1_dclk_out_p
ad_connect tx1_dclk_in_n     axi_adrv9002/tx1_dclk_in_n
ad_connect tx1_dclk_in_p     axi_adrv9002/tx1_dclk_in_p
ad_connect tx1_idata_out_n   axi_adrv9002/tx1_idata_out_n
ad_connect tx1_idata_out_p   axi_adrv9002/tx1_idata_out_p
ad_connect tx1_qdata_out_n   axi_adrv9002/tx1_qdata_out_n
ad_connect tx1_qdata_out_p   axi_adrv9002/tx1_qdata_out_p
ad_connect tx1_strobe_out_n  axi_adrv9002/tx1_strobe_out_n
ad_connect tx1_strobe_out_p  axi_adrv9002/tx1_strobe_out_p

ad_connect tx2_dclk_out_n    axi_adrv9002/tx2_dclk_out_n
ad_connect tx2_dclk_out_p    axi_adrv9002/tx2_dclk_out_p
ad_connect tx2_dclk_in_n     axi_adrv9002/tx2_dclk_in_n
ad_connect tx2_dclk_in_p     axi_adrv9002/tx2_dclk_in_p
ad_connect tx2_idata_out_n   axi_adrv9002/tx2_idata_out_n
ad_connect tx2_idata_out_p   axi_adrv9002/tx2_idata_out_p
ad_connect tx2_qdata_out_n   axi_adrv9002/tx2_qdata_out_n
ad_connect tx2_qdata_out_p   axi_adrv9002/tx2_qdata_out_p
ad_connect tx2_strobe_out_n  axi_adrv9002/tx2_strobe_out_n
ad_connect tx2_strobe_out_p  axi_adrv9002/tx2_strobe_out_p


ad_connect  axi_adrv9002/adc_1_valid axi_adrv9002_rx1_dma/fifo_wr_en
ad_connect  axi_adrv9002/adc_1_data  axi_adrv9002_rx1_dma/fifo_wr_din
ad_connect  axi_adrv9002/adc_1_dovf  axi_adrv9002_rx1_dma/fifo_wr_overflow

ad_connect  axi_adrv9002/adc_2_valid axi_adrv9002_rx2_dma/fifo_wr_en
ad_connect  axi_adrv9002/adc_2_data  axi_adrv9002_rx2_dma/fifo_wr_din
ad_connect  axi_adrv9002/adc_2_dovf  axi_adrv9002_rx2_dma/fifo_wr_overflow

# interconnect

ad_cpu_interconnect 0x44A00000  axi_adrv9002
ad_cpu_interconnect 0x44A30000  axi_adrv9002_rx1_dma
ad_cpu_interconnect 0x44A40000  axi_adrv9002_rx2_dma

# memory inteconnect

ad_mem_hp1_interconnect sys_200m_clk sys_ps7/S_AXI_HP1
ad_mem_hp1_interconnect sys_200m_clk axi_adrv9002_rx1_dma/m_dest_axi
ad_mem_hp1_interconnect sys_200m_clk axi_adrv9002_rx2_dma/m_dest_axi
ad_connect sys_cpu_resetn axi_adrv9002_rx1_dma/m_dest_axi_aresetn
ad_connect sys_cpu_resetn axi_adrv9002_rx2_dma/m_dest_axi_aresetn

# interrupts

ad_cpu_interrupt ps-13 mb-12 axi_adrv9002_rx1_dma/irq
ad_cpu_interrupt ps-14 mb-13 axi_adrv9002_rx2_dma/irq

