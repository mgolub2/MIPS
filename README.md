#Single Cycle MIPS CPU. 

## Maximilian Golub, Michael Von Hippel
 * Reduced instruction set, only supports:
 	* ADDI rt, rs, imm16: Reg[rt] = Reg[rs] + Sign_ext(Imm16).
	* BLTZ rs, Imm16: if (Reg[rs]<0) PC = PC + 4 + Sign_ext(Imm16)<<2 else PC = PC + 4. 
	* J target: PC = { PC[31:28], target, 00 }. 
	* LW rt, imm16(rs): Reg[rt] = Mem[Reg[rs] + Sign_ext(Imm16)].
	* NOR rd, rs, rt: Reg[rd] = Reg[rs] nor Reg[rt].
	* SLTU rd, rs, rt: Reg[rs] and Reg[rt] are considered to be unsigned numbers.
	* SUBU rd, rs, rt: Reg[rd] = Reg[rs] – Reg[rt]. This is normal, 2’s complement subtraction. “subu” completely ignores overflow
	* SW rt, imm16(rs): Mem[Reg[rs] + Sign_ext(Imm16)] = Reg[rt].
 * Simulated using modelsim, all gate delays 50ps.
 * Clocked at 100Mhz via the testbench, could possibly go higher. 
