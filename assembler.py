import sys
import re
from enum import Enum

if len(sys.argv) != 2:
	print("Incorrect usages. Ex: assembler.py code.asm")
	
asmfile = sys.argv[1]

print("Assembling " + asmfile)

ops = dict(zip(['and', 'add', 'xor', 'lsl', 'lsr', 'ldi', 'ldm', 'str', 'bne'], ['000', '001', '010', '011', '011', '100', '101', '110', '111']))
regs = dict(zip(['r0', 'r1', 'r2', 'r3', 'r4', 'r5', 'r6', 'r7'], ['000', '001', '010', '011', '100', '101', '110', '111']))
labelcheck = re.compile("\w+(?=:)")

lines = []
labels = {}
for line in open(asmfile):
	line = line.split(';', 1)[0] #Ignore asm comments
	line = line.strip().lower() #strip extra whitespace and indentations
	
	if labelcheck.match(line):
		line = line.split(':', 1)[0]
		labels[line] = len(lines)	#add labels and label target to dict
		
	elif line:	#only add non blank lines to array
		lines.append(line)

machinecode = []
for i in range(len(lines)):
	instr = re.split(', |\s', lines[i])	
	
	if instr[0] == 'and':
		machinecode.append(ops[instr[0]] + '_' + regs[instr[1]] + '_' + regs[instr[2]])
		
	elif instr[0] == 'add':
		machinecode.append(ops[instr[0]] + '_' + regs[instr[1]] + '_' + regs[instr[2]])
		
	elif instr[0] == 'xor':
		machinecode.append(ops[instr[0]] + '_' + regs[instr[1]] + '_' + regs[instr[2]])
		
	elif instr[0] == 'lsl':
		imm = '{0:02b}'.format(int(instr[2]))
		machinecode.append(ops[instr[0]] + "_" + "0" + "_" + regs[instr[1]] + "_" + imm)
		
	elif instr[0] == 'lsr':
		imm = '{0:02b}'.format(int(instr[2]))
		machinecode.append(ops[instr[0]] + '_' + '1' + '_' + regs[instr[1]] + '_' + imm)
		
	elif instr[0] == 'ldi':
		imm = 'XX'
		if instr[1][0:2] == '0b':
			imm = '{0:06b}'.format(int(instr[1], 2))
		elif instr[1][0:2] == '0x':
			imm = '{0:06b}'.format(int(instr[1], 16))
		elif instr[1].isnumeric():
			imm = '{0:06b}'.format(int(instr[1]))
		else: #get label target pc if loading a label
			for j in range(i+1, len(lines)):
				if re.split(', |\s', lines[j])[0] == 'bne':
					imm = '{0:06b}'.format(labels[instr[1]] - j)
					break
					
		machinecode.append(ops[instr[0]] + '_' + imm)
		
	elif instr[0] == 'ldm':
		machinecode.append(ops[instr[0]] + '_' + regs[instr[1]] + '_' + regs[instr[2]])
		
	elif instr[0] == 'str':
		machinecode.append(ops[instr[0]] + '_' + regs[instr[1]] + '_' + regs[instr[2]])
		
	elif instr[0] == 'bne':
		machinecode.append(ops[instr[0]] + '_' + regs[instr[1]] + '_' + regs[instr[2]])
		
	else: 
		print("Invalid op!!! op = " + instr[0])
		quit()

			
print(lines)
print(labels)

mcfile = open(asmfile + '.mcode', 'w+')
for line in machinecode:
	print (line)
	mcfile.write(line + '\n')
