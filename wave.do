onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal -childformat {{{/mips_testbench/cpu/data/registerFile/data_out[31]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[30]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[29]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[28]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[27]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[26]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[25]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[24]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[23]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[22]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[21]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[20]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[19]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[18]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[17]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[16]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[15]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[14]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[13]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[12]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[11]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[10]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[9]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[8]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[7]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[6]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[5]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[4]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[3]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[2]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[1]} -radix decimal} {{/mips_testbench/cpu/data/registerFile/data_out[0]} -radix decimal}} -expand -subitemconfig {{/mips_testbench/cpu/data/registerFile/data_out[31]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[30]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[29]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[28]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[27]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[26]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[25]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[24]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[23]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[22]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[21]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[20]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[19]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[18]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[17]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[16]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[15]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[14]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[13]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[12]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[11]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[10]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[9]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[8]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[7]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[6]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[5]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[4]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[3]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[2]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[1]} {-height 15 -radix decimal} {/mips_testbench/cpu/data/registerFile/data_out[0]} {-height 15 -radix decimal}} /mips_testbench/cpu/data/registerFile/data_out
add wave -noupdate /mips_testbench/cpu/Instructions
add wave -noupdate /mips_testbench/cpu/signExtend
add wave -noupdate /mips_testbench/cpu/reg_Da
add wave -noupdate /mips_testbench/cpu/target_inst
add wave -noupdate /mips_testbench/cpu/ALUcntrl
add wave -noupdate /mips_testbench/cpu/control_logic/target_inst
add wave -noupdate /mips_testbench/cpu/control_logic/RegWr
add wave -noupdate /mips_testbench/cpu/control_logic/RegDst
add wave -noupdate /mips_testbench/cpu/control_logic/ALUsrc
add wave -noupdate /mips_testbench/cpu/control_logic/ALUcntrl
add wave -noupdate /mips_testbench/cpu/control_logic/MemWr
add wave -noupdate /mips_testbench/cpu/control_logic/MemToReg
add wave -noupdate /mips_testbench/cpu/control_logic/jump
add wave -noupdate /mips_testbench/cpu/control_logic/branch
add wave -noupdate /mips_testbench/cpu/control_logic/clk
add wave -noupdate /mips_testbench/cpu/control_logic/instruction
add wave -noupdate /mips_testbench/cpu/control_logic/I_inst
add wave -noupdate /mips_testbench/cpu/control_logic/R_inst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {300335 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 334
configure wave -valuecolwidth 152
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {205374 ps} {351006 ps}