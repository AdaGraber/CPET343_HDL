# Dr. Kaputa
# Quartus II compile script for DE1-SoC  board

# 1] name your project here
set project_name "seven_seg"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY top
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/top.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_adder_beh.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_counter.vhd
set_global_assignment -name VHDL_FILE ../../src/seven_seg.vhd

# 3] set your pin constraints here
set_location_assignment PIN_AB12 -to reset
set_location_assignment PIN_AF14 -to clk
set_location_assignment PIN_V16  -to led
set_location_assignment PIN_AE26 -to HEX0[0]
set_location_assignment PIN_AE27 -to HEX0[1]
set_location_assignment PIN_AE28 -to HEX0[2]
set_location_assignment PIN_AG27 -to HEX0[3]
set_location_assignment PIN_AF28 -to HEX0[4]
set_location_assignment PIN_AG28 -to HEX0[5]
set_location_assignment PIN_AH28  -to HEX0[6]
set_location_assignment PIN_AJ29  -to HEX1[0]
set_location_assignment PIN_AH29  -to HEX1[1]
set_location_assignment PIN_AH30  -to HEX1[2]
set_location_assignment PIN_AG30  -to HEX1[3]
set_location_assignment PIN_AF29  -to HEX1[4]
set_location_assignment PIN_AF30  -to HEX1[5]
set_location_assignment PIN_AD27  -to HEX1[6]
set_location_assignment PIN_AB23 -to HEX2[0]
set_location_assignment PIN_AE29  -to HEX2[1]
set_location_assignment PIN_AD29  -to HEX2[2]
set_location_assignment PIN_AC28  -to HEX2[3]
set_location_assignment PIN_AD30  -to HEX2[4]
set_location_assignment PIN_AC29  -to HEX2[5]
set_location_assignment PIN_AC30  -to HEX2[6]
set_location_assignment PIN_AD26  -to HEX3[0]
set_location_assignment PIN_AC27  -to HEX3[1]
set_location_assignment PIN_AD25 -to HEX3[2]
set_location_assignment PIN_AC25  -to HEX3[3]
set_location_assignment PIN_AB28  -to HEX3[4]
set_location_assignment PIN_AB25  -to HEX3[5]
set_location_assignment PIN_AB22  -to HEX3[6]

execute_flow -compile
project_close