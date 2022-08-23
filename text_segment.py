import numpy as np


# -----------------------------------------------------------
# Returns the first available code segment in bytes. If there is no such segment, it returns None.
# Algorithm of this function is described in the text of the master's thesis.
# It contains a lot of magic constants related to the structure of elf.
# They are also described in the text of the master's thesis.
#
# Parameters:
#
# filename: path to file for extracting a code segment
# -----------------------------------------------------------
def text_segment(filename):
	# Opening file and converting it to bytes
	file = open(filename, "r")
	bytes = np.fromfile(filename, dtype = "uint8")

	# Getting a link to the section header table
	e_shoff = bytes[0x28:0x30]

	# Getting the start of the section header table
	pointer_header_table = 0
	for i in range(len(e_shoff)):
		pointer_header_table = pointer_header_table + (e_shoff[i] % 16) * 16 ** (2 * i) + (e_shoff[i] // 16) * 16 ** (2 * i + 1)

	# Getting an index of .shstrtab in the .shstrtab section
	e_shstrndx = bytes[0x3E:0x40]

	# Getting an index of the section header table entry that contains the section names
	index_shstrtab = 0 
	for i in range(len(e_shstrndx)):
		index_shstrtab = index_shstrtab + (e_shstrndx[i] % 16) * 16 ** (2 * i) + (e_shstrndx[i] // 16) * 16 ** (2 * i + 1)

	# Getting a link to the .shstrtab
	pointer_shstrtab_in_shstrtab = pointer_header_table + index_shstrtab * 0x40

	# Getting an offset of the .shstrtab section from the beginning of the file in bytes
	sh_offset = bytes[pointer_shstrtab_in_shstrtab + 0x18: pointer_shstrtab_in_shstrtab + 0x20]

	# Getting the start of the .shstrtab section
	pointer_shstrtab = 0
	for i in range(len(sh_offset)):
		pointer_shstrtab = pointer_shstrtab + (sh_offset[i] % 16) * 16 ** (2 * i) + (sh_offset[i] // 16) * 16 ** (2 * i + 1)
	
	# Passing through .shstrtab section in order to find information about .text section
	j = pointer_header_table + 0x40 # there are zeros at the beginning of the table
	while j < len(bytes):
		# Getting an offset to a string in the .shstrtab section that represents the name of this section.
		sh_name = bytes[j:j + 0x4]
		offset_string = 0 
		for i in range(len(sh_name)):
			offset_string = offset_string + (sh_name[i] % 16) * 16 ** (2 * i) + (sh_name[i] // 16) * 16 ** (2 * i + 1)

		# Comparing with ".text\0"
		text_code = [0x2e, 0x74, 0x65, 0x78, 0x74, 0x00] # .text\0
		to_continue = False
		for k in range(len(text_code)):
			if bytes[pointer_shstrtab + offset_string + k] != text_code[k]:
				to_continue = True
				break;

		# If it is not .text section then continue with next section
		if to_continue:
			j = j + 0x40
			continue
		
		# If we got here, then we are in the .text section. We can find out and return everything we need
		# Getting an offset to .text segment
		sh_offset_text = bytes[j + 0x18 : j + 0x20]
		pointer_text = 0
		for i in range(len(sh_offset_text)):
			pointer_text = pointer_text + (sh_offset_text[i] % 16) * 16 ** (2 * i) + (sh_offset_text[i] // 16) * 16 ** (2 * i + 1)

		# Getting size of .text segment
		sh_size_text = bytes[j + 0x20 : j + 0x28]
		size_text = 0
		for i in range(len(sh_size_text)):
			size_text = size_text + (sh_size_text[i] % 16) * 16 ** (2 * i) + (sh_size_text[i] // 16) * 16 ** (2 * i + 1)

		# Returning .text segment
		return bytes[pointer_text : pointer_text + size_text]

	return None
