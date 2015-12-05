# .do file for automating a modelsim run of the mips cpu
# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.

#Lab 1 included
vlog "./EE471_Lab1/Mux2x1.sv"
vlog "./EE471_Lab1/Mux2x1_testbench.sv"
vlog "./EE471_Lab1/Mux4x1.sv"
vlog "./EE471_Lab1/Mux4x1_testbench.sv"
vlog "./EE471_Lab1/Mux16x1.sv"
vlog "./EE471_Lab1/Mux16x1_testbench.sv"
vlog "./EE471_Lab1/Mux32x1.sv"
vlog "./EE471_Lab1/Mux32x1_testbench.sv"
vlog "./EE471_Lab1/Mux32x32.sv"
vlog "./EE471_Lab1/Mux32x32_testbench.sv"
vlog "./EE471_Lab1/D_FF.sv"
vlog "./EE471_Lab1/Register_32.sv"
vlog "./EE471_Lab1/Decoder3x8.sv"
vlog "./EE471_Lab1/Decoder3x8_testbench.sv"
vlog "./EE471_Lab1/Decoder5x32.sv"
vlog "./EE471_Lab1/Decoder5x32_testbench.sv"
vlog "./EE471_Lab1/regfile.sv"
vlog "./EE471_Lab1/regstim.sv"

# Lab 2 included
vlog "./EE471_Lab2/adder_pg.sv"
vlog "./EE471_Lab2/ks_sub.sv"
vlog "./EE471_Lab2/adder.sv"
vlog "./EE471_Lab2/adder_testbench.sv"
vlog "./EE471_Lab2/ks_sub_testbench.sv"
vlog "./EE471_Lab2/nor_testbench.sv"
vlog "./EE471_Lab2/nor.sv"
vlog "./EE471_Lab2/sltu.sv"
vlog "./EE471_Lab2/sltu_testbench.sv"
vlog "./EE471_Lab2/Mux2x1.sv"
vlog "./EE471_Lab2/Mux_32_2x1.sv"
vlog "./EE471_Lab2/Mux_32_2x1_testbench.sv"
vlog "./EE471_Lab2/Mux_32_4x1.sv"
vlog "./EE471_Lab2/Mux_32_4x1_testbench.sv"
vlog "./EE471_Lab2/zero_test.sv"
vlog "./EE471_Lab2/zero_test_testbench.sv"
vlog "./EE471_Lab2/negative.sv"
vlog "./EE471_Lab2/alu.sv"
vlog "./EE471_Lab2/ALUStimulus.sv"


vlog "./concat.sv"
vlog "./dataMem.sv"
vlog "./InstructionMem.sv"
vlog "./pc.sv" +incdir+./EE471_Lab2 +incdir+./EE471_Lab1
vlog "./signExtend.sv"
vlog "./signExtend_testbench.sv"
vlog "./datapath.sv" +incdir+./EE471_Lab2 +incdir+./EE471_Lab1
vlog "./datapath_testbench.sv" +incdir+./EE471_Lab2 +incdir+./EE471_Lab1
vlog "./control.sv"
vlog "./mips.sv"
vlog "./mips_testbench.sv"
vlog "./register.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.

#vsim -voptargs="+acc" -t 1ps -lib work signExtend_testbench
# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.

#do signExtend_wave.do

vsim -voptargs="+acc" -t 1ps -lib work datapath_testbench
# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.

do datapath_wave.do

#vsim -voptargs="+acc" -t 1ps -lib work mips_testbench
#vsim -voptargs="+acc" -t 1ps -lib work pc_testbench
#do pc.do
#do mips.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
