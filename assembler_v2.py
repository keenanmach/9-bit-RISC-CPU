#!/usr/bin/env python
# coding: utf-8

# In[174]:


# max immediate loadable from ldi
INSTR_LENGTH = 9
MAX_IMM = 63
IMM_STR = '111111'
REG_LENGTH = 3

I_FSTR = '{}_{}'
R_FSTR = '{}_{}_{}'

# ops dictionary
ops = {
    'and': '000',
    'add': '001',
    'xor': '010',
    'lsl': '0110',
    'lsr': '0111',
    'ldi': '100',
    'ldm': '101',
    'str': '110',
    'bne': '111'
}

# register dictionary
regs = {
    'r0': '000',
    'r1': '001',
    'r2': '010',
    'r3': '011',
    'r4': '100',
    'r5': '101',
    'r6': '110',
    'r7': '111',
    'lr': '001',
    'br': '001',
    'res': '000'
}

# bits left for immediates
imm_bits = {
    'ldi': INSTR_LENGTH - len(ops['ldi']),
    'lsl': INSTR_LENGTH - len(ops['lsl']) - REG_LENGTH,
    'lsr': INSTR_LENGTH - len(ops['lsr']) - REG_LENGTH
}

# labels
labels = {}	

# instruction sets
r_instr = {'and', 'add', 'xor', 'str', 'ldm', 'bne'}
i_instr = {'ldi', 'lsl', 'lsr'}
p_instr = {'addi', 'ldr', 'ldz', 'mov'}

asmfile = 'fix2float.asm'

# immediate to decimal
def imm_to_decimal(imm):
    if imm.startswith('0b'):
        return int(imm[2:], 2)
    elif imm.startswith('0x'):
        return int(imm[2:], 16)
    elif imm.isdigit():
        return int(imm)
    
# immediate to binary string with zero padding
def convert_immediate(op, imm):
    if imm.startswith('0b'):        
        return imm[2:].zfill(imm_bits[op])
    elif imm.startswith('0x'):
        ret = bin(int(imm[2:], 16))[2:]
        return ret.zfill(imm_bits[op])
    elif imm.isdigit():    
        ret = bin(int(imm))[2:]
        return ret.zfill(imm_bits[op])
    else:
        return imm

# r type instruction to machine code
def convert_r_instr(op, rs, rt):
    return R_FSTR.format(ops[op], regs[rs], regs[rt])

# i type instruction to machine code
def convert_i_instr(op, pos1, pos2=None):
    if op == 'ldi':
        return I_FSTR.format(ops[op], convert_immediate(op, pos1))
    else:
        pos2 = str(imm_to_decimal(pos2)-1)
        return R_FSTR.format(ops[op], regs[pos1], convert_immediate(op,pos2))

# pseudoinstructions to machine code
def convert_p_instr(op, rest, label=False):
    if op == 'addi':
        reg = rest[0]
        imm = imm_to_decimal(rest[1])
        if imm > 2 ** INSTR_LENGTH:
            raise Exception()        
        elif imm > MAX_IMM:
            # instr_list = [ldi 31, add reg, lr]
            instr_list = [convert_i_instr('ldi', str(MAX_IMM)),
                         convert_r_instr('add', reg, 'lr')]
            while imm > MAX_IMM:
                # instr_list += add reg, lr
                instr_list.append(convert_r_instr('add', reg, 'lr'))
                imm = imm - MAX_IMM
            if imm != 0:
                # instr_list += ldi (imm%31)
                # instr_list += add reg, lr
                instr_list.append(convert_i_instr('ldi', str(imm)))
                instr_list.append(convert_r_instr('add', reg, 'lr'))
            return instr_list
        else:
            return [convert_i_instr('ldi', str(imm)),
                    convert_r_instr('add', reg, 'lr')]
        
    elif op == 'ldz':
        reg = rest[0]
        return [convert_i_instr('ldi', '0'),
               convert_r_instr('and', reg, 'lr')]
    
    elif op == 'mov':
        rs = rest[0]
        rt = rest[1]
        return convert_p_str('ldz', rs) + [convert_r_instr('add', rs, rt)]
    
    elif op == 'ldr':
        reg = rest[0]
        imm = rest[1]
        if not label:
            return convert_p_instr('ldz', [reg]) + convert_p_instr('addi', rest)
        else:
            imm = bin(imm_to_decimal(imm))[2:].zfill(8)
            print(imm)
            return convert_p_instr('ldz', [reg]) + [convert_i_instr('ldi', str(imm >> 2))] + [convert_r_instr('add', reg, 'lr')] + [convert_i_instr('lsl', reg, '2')] + [convert_i_instr('ldi', str(imm & 3))] + [convert_r_instr('add'), 'lr', reg]

# instruction to machine code
def convert_instr(instr):
    op = instr[0]
    if op in r_instr:
        return convert_r_instr(*instr)
    elif op in i_instr:
        return convert_i_instr(*instr)
    elif op in p_instr:
        return convert_p_instr(op, instr[1:])
		
def line_contains_label(line):
    for label in labels:
	    if label[:len(label)-1] in line:
		    return True
    return False
	
def convert_load_label(line):
	reg = regs[line.split('_')[1]]
    label = line.split('_')[2]
    line_number = labels[label+':']
    return convert_p_instr('ldr', ['br', str(line_number)], label=True)
	              
	
# Convert pseudoinstructions
with open(asmfile, 'r') as rf:
    lines = rf.readlines()

# converts assembly file to machine code, ignores branching
machinecode = []
for i in range(len(lines)):
    line = lines[i]
    instr = line.lower().strip().split(';')[0].strip().replace(',','').split()
    
    if len(instr) == 0:
	    pass
    elif len(instr) == 1:
        machinecode.append(instr)
        #labels.add(instr[0])
    else:
        converted_instruction = convert_instr(instr)
        if isinstance(converted_instruction, list):
            machinecode.extend(converted_instruction)
        else:
            machinecode.append(converted_instruction)
            
# get branch labels
for i in range(len(machinecode)):
    if isinstance(machinecode[i], list):
        labels[machinecode[i][0]] = None


# In[175]:


#for line in machinecode:
    #print(line)

final_machinecode = []

mcfile = open(asmfile + '2'+ '.mcode', 'w+')
for line in machinecode:
    if isinstance(line, list):
        final_machinecode.append(line)
    else:	
        if line_contains_label(line):
		    final_machinecode.extend([line] + ['nop']*6)
        else:
		    final_machinecode.append(line)
			
			
for line in final_machinecode:
    #print(line)
    pass
	
# set label values
non_label_instr_count = 0
codes = {}
for i in range(len(final_machinecode)):
    if isinstance(final_machinecode[i], list):
        labels[final_machinecode[i][0]] = non_label_instr_count
    else:
        codes[non_label_instr_count] = final_machinecode[i]
        non_label_instr_count += 1
		
#print(labels)
#for key, value in codes.items():
#    print(str(key) + ',' + str(value))    
	
final_machinecode = [x for x in final_machinecode if not isinstance(x, list)]
for line in final_machinecode:
    #print(line)
	pass

print(labels)
print(convert_load_label('100_010_loop'))


# In[ ]:





# In[ ]:




