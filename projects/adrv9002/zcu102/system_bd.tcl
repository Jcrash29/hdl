
## FIFO depth is 18Mb - 1M samples
#set dac_fifo_address_width 17

## NOTE: With this configuration the #36Kb BRAM utilization is at ~57%

source $ad_hdl_dir/projects/common/zcu102/zcu102_system_bd.tcl
#source $ad_hdl_dir/projects/common/xilinx/dacfifo_bd.tcl

source ../common/adrv9002_bd.tcl

