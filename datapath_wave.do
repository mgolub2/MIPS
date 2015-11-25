onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /datapath_testbench/dut/clk
add wave -noupdate -radix binary /datapath_testbench/Instructions
add wave -noupdate -radix binary /datapath_testbench/dut/registerFile/RegWrite
add wave -noupdate -radix decimal /datapath_testbench/dut/SE/out
add wave -noupdate -radix binary /datapath_testbench/dut/RegDst
add wave -noupdate -radix binary /datapath_testbench/dut/RegWr
add wave -noupdate -radix binary /datapath_testbench/dut/ALUsrc
add wave -noupdate -radix binary /datapath_testbench/dut/MemWr
add wave -noupdate -radix binary /datapath_testbench/dut/MemToReg
add wave -noupdate /datapath_testbench/dut/ALUcntrl
add wave -noupdate -radix binary /datapath_testbench/dut/Instructions
add wave -noupdate -radix binary /datapath_testbench/dut/Zero
add wave -noupdate -radix decimal /datapath_testbench/dut/seOut
add wave -noupdate -radix decimal /datapath_testbench/dut/Imm16
add wave -noupdate -radix decimal /datapath_testbench/dut/se32
add wave -noupdate -radix decimal /datapath_testbench/dut/Dw
add wave -noupdate -radix decimal /datapath_testbench/dut/Da
add wave -noupdate -radix decimal /datapath_testbench/dut/Db
add wave -noupdate -radix decimal /datapath_testbench/dut/Dout
add wave -noupdate -radix decimal /datapath_testbench/dut/ALUin
add wave -noupdate -radix decimal /datapath_testbench/dut/ALUout
add wave -noupdate -radix decimal /datapath_testbench/dut/Aw
add wave -noupdate -radix decimal /datapath_testbench/dut/Rs
add wave -noupdate -radix decimal /datapath_testbench/dut/Rd
add wave -noupdate -radix decimal /datapath_testbench/dut/Rt
add wave -noupdate -radix binary /datapath_testbench/dut/overflow
add wave -noupdate -radix binary /datapath_testbench/dut/carryout
add wave -noupdate -radix binary /datapath_testbench/dut/negative
add wave -noupdate -radix decimal -childformat {{{/datapath_testbench/dut/registerFile/data_out[31]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[30]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[29]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[28]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[27]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[26]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[25]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[24]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[23]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[22]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[21]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[20]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[19]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[18]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[17]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[16]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[15]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[14]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[13]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[12]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[11]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[10]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[9]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[8]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[7]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[6]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[5]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[4]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[3]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[2]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[1]} -radix decimal} {{/datapath_testbench/dut/registerFile/data_out[0]} -radix decimal}} -expand -subitemconfig {{/datapath_testbench/dut/registerFile/data_out[31]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[30]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[29]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[28]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[27]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[26]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[25]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[24]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[23]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[22]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[21]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[20]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[19]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[18]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[17]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[16]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[15]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[14]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[13]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[12]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[11]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[10]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[9]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[8]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[7]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[6]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[5]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[4]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[3]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[2]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[1]} {-height 15 -radix decimal} {/datapath_testbench/dut/registerFile/data_out[0]} {-height 15 -radix decimal}} /datapath_testbench/dut/registerFile/data_out
add wave -noupdate -radix decimal /datapath_testbench/dut/dataMemory/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {161429 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 381
configure wave -valuecolwidth 140
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
configure wave -timelineunits ns
update
WaveRestoreZoom {284038 ps} {511366 ps}
