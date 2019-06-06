
source ../../scripts/adi_env.tcl
source $ad_hdl_dir/projects/scripts/adi_project.tcl
source $ad_hdl_dir/projects/scripts/adi_board.tcl

adi_project_xilinx adrv9002_vc707
adi_project_files adrv9002_vc707 [list \
  "system_top.v" \
  "system_constr.xdc"\
  "$ad_hdl_dir/library/xilinx/common/ad_iobuf.v" \
  "$ad_hdl_dir/projects/common/vc707/vc707_system_constr.xdc"]

## To improve timing of the BRAM buffers
set_property strategy Performance_RefinePlacement [get_runs impl_1]

adi_project_run adrv9002_vc707

