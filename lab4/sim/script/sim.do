vlib work
vcom -93 -work work ../../src/synchronizer_3bit.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/bcd.vhd
vcom -93 -work work ../../src/add_or_sub.vhd
vcom -93 -work work ../../src/lab4.vhd
vcom -93 -work work ../src/lab4_tb.vhd
vsim -voptargs=+acc lab4_tb
do wave.do
run 1300 ns
