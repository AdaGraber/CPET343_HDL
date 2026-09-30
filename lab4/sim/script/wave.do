onerror {resume}
radix define States {
    "7'b1000000" "0" -color "red",
    "7'b1111001" "1" -color "red",
    "7'b0100100" "2" -color "red",
    "7'b0110000" "3" -color "red",
    "7'b0011001" "4" -color "red",
    "7'b0010010" "5" -color "red",
    "7'b0000010" "6" -color "red",
    "7'b1111000" "7" -color "red",
    "7'b0000000" "8" -color "red",
    "7'b0011000" "9" -color "red",
    "7'b0001000" "A" -color "red",
    "7'b0000011" "B" -color "red",
    "7'b0100001" "C" -color "red",
    "7'b0110011" "D" -color "red",
    "7'b0000110" "E" -color "red",
    "7'b0001110" "F" -color "red",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab4_tb/clk
add wave -noupdate /lab4_tb/reset
add wave -noupdate /lab4_tb/a_in
add wave -noupdate /lab4_tb/b_in
add wave -noupdate /lab4_tb/addi
add wave -noupdate /lab4_tb/subt
add wave -noupdate -radix States /lab4_tb/hex_a
add wave -noupdate -radix States /lab4_tb/hex_b
add wave -noupdate -radix States /lab4_tb/hex_r
add wave -noupdate -expand -group uut /lab4_tb/uut/sync_add_pb
add wave -noupdate -expand -group uut /lab4_tb/uut/sw_a
add wave -noupdate -expand -group uut /lab4_tb/uut/sw_b
add wave -noupdate -expand -group uut /lab4_tb/uut/pb_add
add wave -noupdate -expand -group uut /lab4_tb/uut/pb_sub
add wave -noupdate -expand -group uut /lab4_tb/uut/CLOCK_50
add wave -noupdate -expand -group uut /lab4_tb/uut/reset
add wave -noupdate -expand -group uut /lab4_tb/uut/seven_seg_a
add wave -noupdate -expand -group uut /lab4_tb/uut/seven_seg_b
add wave -noupdate -expand -group uut /lab4_tb/uut/seven_seg_result
add wave -noupdate -expand -group uut /lab4_tb/uut/sync_sub_pb
add wave -noupdate -expand -group uut /lab4_tb/uut/op
add wave -noupdate -expand -group uut /lab4_tb/uut/a_to_bcd
add wave -noupdate -expand -group uut /lab4_tb/uut/b_to_bcd
add wave -noupdate -expand -group uut /lab4_tb/uut/result
add wave -noupdate -expand -group uut /lab4_tb/uut/a
add wave -noupdate -expand -group uut /lab4_tb/uut/b
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1365 ns}
