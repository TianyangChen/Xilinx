
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name smart_car -dir "C:/Xilinx/smart_car/planAhead_run_1" -part xc3s100ecp132-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Xilinx/smart_car/monitor.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Xilinx/smart_car} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "monitor.ucf" [current_fileset -constrset]
add_files [list {monitor.ucf}] -fileset [get_property constrset [current_run]]
open_netlist_design
