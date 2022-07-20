import os
import numpy

from text_segment import text_segment


# -----------------------------------------------------------
# Passes through given source directory and it's subdirectories,
# for each file counts propotion of each binary substring with length 1.
# Returns numpy array with propotions. Each column of numpy array contains
# propotions of certain substring for all files. Substrings arranged 
# in lexicographic order.
# Example output:
# [['0' '1']
# ['0.6' '0.4']
# ['0.5' '0.5']]
#
# Parameters:
#
# source: path to directory with executable binary files
# -----------------------------------------------------------
def proportions_length_1(source):
	# List with propotions of "0" substring
	propotions_of_0 = ["0--x86_64-g++-ubuntu"]
	# List with propotions of "1" substring
	propotions_of_1 = ["1--x86_64-g++-ubuntu"]

	# Passing and counting propotions function
	def pass_and_count(source):
		nonlocal propotions_of_0, propotions_of_1

		# Passing through all subdirectories
		for subdir in os.listdir(source):
			# Getting subdirectory's path
			path_to_subdir = source + "/" + subdir

			# If it is subdirectory then call this function
			if os.path.isdir(path_to_subdir):
				pass_and_count(path_to_subdir)
			# If it is file
			else:
				# Printing file name
				print(path_to_subdir)
				# Getting text segment in bytes
				bytes = text_segment(path_to_subdir)
				# Converting text segment to bits
				bits = numpy.unpackbits(bytes)

				# Counting propotion of "0" substring
				propotions_of_0.append(numpy.count_nonzero(bits == 0) / len(bits))
				# Counting propotion of "1" substring
				propotions_of_1.append(numpy.count_nonzero(bits == 1) / len(bits))
	
	# Passing and counting propotions
	pass_and_count(source)

	# Converting propotions to required form
	return numpy.asarray([propotions_of_0, propotions_of_1]).transpose()


# -----------------------------------------------------------
# Passes through given source directory and it's subdirectories,
# for each file counts propotion of each binary substring with length 2.
# Returns numpy array with propotions. Each column of numpy array contains
# propotions of certain substring for all files. Substrings arranged 
# in lexicographic order.
#
# Parameters:
#
# source: path to directory with executable binary files
# -----------------------------------------------------------
def proportions_length_2(source):
	# List with propotions of "00" substring
	propotions_of_00 = ["00--x86_64-g++-ubuntu"]
	# List with propotions of "01" substring
	propotions_of_01 = ["01--x86_64-g++-ubuntu"]
	# List with propotions of "10" substring
	propotions_of_10 = ["10--x86_64-g++-ubuntu"]
	# List with propotions of "11" substring
	propotions_of_11 = ["11--x86_64-g++-ubuntu"]

	# Passing and counting propotions function
	def pass_and_count(source):
		nonlocal propotions_of_00, propotions_of_01, propotions_of_10, propotions_of_11

		# Passing through all subdirectories
		for subdir in os.listdir(source):
			# Getting subdirectory's path
			path_to_subdir = source + "/" + subdir

			# If it is subdirectory then call this function
			if os.path.isdir(path_to_subdir):
				pass_and_count(path_to_subdir)
			# If it is file
			else:
				# Printing file name
				print(path_to_subdir)
				# Getting text segment in bytes
				bytes = text_segment(path_to_subdir)
				# Converting text segment to bits
				bits = numpy.unpackbits(bytes)

				# Counter for "00" substrings in file
				counter_00 = 0
				# Counter for "01" substrings in file
				counter_01 = 0
				# Counter for "10" substrings in file
				counter_10 = 0
				# Counter for "11" substrings in file
				counter_11 = 0

				# Cycle throuth bits for counting substrings
				for i in range(0, len(bits) - 1):
					if bits[i] == 0 and bits[i + 1] == 0:
						counter_00 = counter_00 + 1
					elif bits[i] == 0 and bits[i + 1] == 1:
						counter_01 = counter_01 + 1
					elif bits[i] == 1 and bits[i + 1] == 0:
						counter_10 = counter_10 + 1
					elif bits[i] == 1 and bits[i + 1] == 1:
						counter_11 = counter_11 + 1

				# Counting propotion of "00" substring
				propotions_of_00.append(counter_00 / (len(bits) - 1))
				# Counting propotion of "01" substring
				propotions_of_01.append(counter_01 / (len(bits) - 1))
				# Counting propotion of "10" substring
				propotions_of_10.append(counter_10 / (len(bits) - 1))
				# Counting propotion of "11" substring
				propotions_of_11.append(counter_11 / (len(bits) - 1))
	
	# Passing and counting propotions
	pass_and_count(source)

	# Converting propotions to required form
	return numpy.asarray([propotions_of_00, propotions_of_01, propotions_of_10, propotions_of_11]).transpose()


# -----------------------------------------------------------
# Passes through given source directory and it's subdirectories,
# for each file counts propotion of each binary substring with length 3.
# Returns numpy array with propotions. Each column of numpy array contains
# propotions of certain substring for all files. Substrings arranged 
# in lexicographic order.
#
# Parameters:
#
# source: path to directory with executable binary files
# -----------------------------------------------------------
def proportions_length_3(source):
	# List with propotions of "000" substring
	propotions_of_000 = ["000--x86_64-g++-ubuntu"]
	# List with propotions of "001" substring
	propotions_of_001 = ["001--x86_64-g++-ubuntu"]
	# List with propotions of "010" substring
	propotions_of_010 = ["010--x86_64-g++-ubuntu"]
	# List with propotions of "011" substring
	propotions_of_011 = ["011--x86_64-g++-ubuntu"]
	# List with propotions of "100" substring
	propotions_of_100 = ["100--x86_64-g++-ubuntu"]
	# List with propotions of "101" substring
	propotions_of_101 = ["101--x86_64-g++-ubuntu"]
	# List with propotions of "110" substring
	propotions_of_110 = ["110--x86_64-g++-ubuntu"]
	# List with propotions of "111" substring
	propotions_of_111 = ["111--x86_64-g++-ubuntu"]

	# Passing and counting propotions function
	def pass_and_count(source):
		nonlocal propotions_of_000, propotions_of_001, propotions_of_010, propotions_of_011, \
			propotions_of_100, propotions_of_101, propotions_of_110, propotions_of_111

		# Passing through all subdirectories
		for subdir in os.listdir(source):
			# Getting subdirectory's path
			path_to_subdir = source + "/" + subdir

			# If it is subdirectory then call this function
			if os.path.isdir(path_to_subdir):
				pass_and_count(path_to_subdir)
			# If it is file
			else:
				# Printing file name
				print(path_to_subdir)
				# Getting text segment in bytes
				bytes = text_segment(path_to_subdir)
				# Converting text segment to bits
				bits = numpy.unpackbits(bytes)

				# Counter for "000" substrings in file
				counter_000 = 0
				# Counter for "001" substrings in file
				counter_001 = 0
				# Counter for "010" substrings in file
				counter_010 = 0
				# Counter for "011" substrings in file
				counter_011 = 0
				# Counter for "100" substrings in file
				counter_100 = 0
				# Counter for "101" substrings in file
				counter_101 = 0
				# Counter for "110" substrings in file
				counter_110 = 0
				# Counter for "111" substrings in file
				counter_111 = 0

				# Cycle throuth bits for counting substrings
				for i in range(0, len(bits) - 2):
					if bits[i] == 0 and bits[i + 1] == 0 and bits[i + 2] == 0:
						counter_000 = counter_000 + 1
					elif bits[i] == 0 and bits[i + 1] == 0 and bits[i + 2] == 1:
						counter_001 = counter_001 + 1
					elif bits[i] == 0 and bits[i + 1] == 1 and bits[i + 2] == 0:
						counter_010 = counter_010 + 1
					elif bits[i] == 0 and bits[i + 1] == 1 and bits[i + 2] == 1:
						counter_011 = counter_011 + 1
					elif bits[i] == 1 and bits[i + 1] == 0 and bits[i + 2] == 0:
						counter_100 = counter_100 + 1
					elif bits[i] == 1 and bits[i + 1] == 0 and bits[i + 2] == 1:
						counter_101 = counter_101 + 1
					elif bits[i] == 1 and bits[i + 1] == 1 and bits[i + 2] == 0:
						counter_110 = counter_110 + 1
					elif bits[i] == 1 and bits[i + 1] == 1 and bits[i + 2] == 1:
						counter_111 = counter_111 + 1

				# Counting propotion of "000" substring
				propotions_of_000.append(counter_000 / (len(bits) - 2))
				# Counting propotion of "001" substring
				propotions_of_001.append(counter_001 / (len(bits) - 2))
				# Counting propotion of "010" substring
				propotions_of_010.append(counter_010 / (len(bits) - 2))
				# Counting propotion of "011" substring
				propotions_of_011.append(counter_011 / (len(bits) - 2))
				# Counting propotion of "100" substring
				propotions_of_100.append(counter_100 / (len(bits) - 2))
				# Counting propotion of "101" substring
				propotions_of_101.append(counter_101 / (len(bits) - 2))
				# Counting propotion of "110" substring
				propotions_of_110.append(counter_110 / (len(bits) - 2))
				# Counting propotion of "111" substring
				propotions_of_111.append(counter_111 / (len(bits) - 2))
	
	# Passing and counting propotions
	pass_and_count(source)

	# Converting propotions to required form
	return numpy.asarray([propotions_of_000, propotions_of_001, propotions_of_010, propotions_of_011, propotions_of_100, \
		propotions_of_101, propotions_of_110, propotions_of_111]).transpose()


# -----------------------------------------------------------
# Passes through given source directory and it's subdirectories,
# for each file counts propotion of each binary substring with length 4.
# Returns numpy array with propotions. Each column of numpy array contains
# propotions of certain substring for all files. Substrings arranged 
# in lexicographic order.
#
# Parameters:
#
# source: path to directory with executable binary files
# -----------------------------------------------------------
def proportions_length_4(source):
	# List with propotions of "0000" substring
	propotions_of_0000 = ["0000--x86_64-g++-ubuntu"]
	# List with propotions of "0001" substring
	propotions_of_0001 = ["0001--x86_64-g++-ubuntu"]
	# List with propotions of "0010" substring
	propotions_of_0010 = ["0010--x86_64-g++-ubuntu"]
	# List with propotions of "0011" substring
	propotions_of_0011 = ["0011--x86_64-g++-ubuntu"]
	# List with propotions of "0100" substring
	propotions_of_0100 = ["0100--x86_64-g++-ubuntu"]
	# List with propotions of "0101" substring
	propotions_of_0101 = ["0101--x86_64-g++-ubuntu"]
	# List with propotions of "0110" substring
	propotions_of_0110 = ["0110--x86_64-g++-ubuntu"]
	# List with propotions of "0111" substring
	propotions_of_0111 = ["0111--x86_64-g++-ubuntu"]
	# List with propotions of "1000" substring
	propotions_of_1000 = ["1000--x86_64-g++-ubuntu"]
	# List with propotions of "1001" substring
	propotions_of_1001 = ["1001--x86_64-g++-ubuntu"]
	# List with propotions of "1010" substring
	propotions_of_1010 = ["1010--x86_64-g++-ubuntu"]
	# List with propotions of "1011" substring
	propotions_of_1011 = ["1011--x86_64-g++-ubuntu"]
	# List with propotions of "1100" substring
	propotions_of_1100 = ["1100--x86_64-g++-ubuntu"]
	# List with propotions of "1101" substring
	propotions_of_1101 = ["1101--x86_64-g++-ubuntu"]
	# List with propotions of "1110" substring
	propotions_of_1110 = ["1110--x86_64-g++-ubuntu"]
	# List with propotions of "1111" substring
	propotions_of_1111 = ["1111--x86_64-g++-ubuntu"]

	# Passing and counting propotions function
	def pass_and_count(source):
		nonlocal propotions_of_0000, propotions_of_0001, propotions_of_0010, propotions_of_0011, \
 			propotions_of_0100, propotions_of_0101, propotions_of_0110, propotions_of_0111, \
			propotions_of_1000, propotions_of_1001, propotions_of_1010, propotions_of_1011, \
			propotions_of_1100, propotions_of_1101, propotions_of_1110, propotions_of_1111

		# Passing through all subdirectories
		for subdir in os.listdir(source):
			# Getting subdirectory's path
			path_to_subdir = source + "/" + subdir

			# If it is subdirectory then call this function
			if os.path.isdir(path_to_subdir):
				pass_and_count(path_to_subdir)
			# If it is file
			else:
				# Printing file name
				print(path_to_subdir)
				# Getting text segment in bytes
				bytes = text_segment(path_to_subdir)
				# Converting text segment to bits
				bits = numpy.unpackbits(bytes)

				# Counter for "0000" substrings in file
				counter_0000 = 0
				# Counter for "0001" substrings in file
				counter_0001 = 0
				# Counter for "0010" substrings in file
				counter_0010 = 0
				# Counter for "0011" substrings in file
				counter_0011 = 0
				# Counter for "0100" substrings in file
				counter_0100 = 0
				# Counter for "0101" substrings in file
				counter_0101 = 0
				# Counter for "0110" substrings in file
				counter_0110 = 0
				# Counter for "0111" substrings in file
				counter_0111 = 0
				# Counter for "1000" substrings in file
				counter_1000 = 0
				# Counter for "1001" substrings in file
				counter_1001 = 0
				# Counter for "1010" substrings in file
				counter_1010 = 0
				# Counter for "1011" substrings in file
				counter_1011 = 0
				# Counter for "1100" substrings in file
				counter_1100 = 0
				# Counter for "1101" substrings in file
				counter_1101 = 0
				# Counter for "1110" substrings in file
				counter_1110 = 0
				# Counter for "1111" substrings in file
				counter_1111 = 0

				# Cycle throuth bits for counting substrings
				for i in range(0, len(bits) - 3):
					if bits[i] == 0 and bits[i + 1] == 0 and bits[i + 2] == 0 and bits[i + 3] == 0:
						counter_0000 = counter_0000 + 1
					elif bits[i] == 0 and bits[i + 1] == 0 and bits[i + 2] == 0 and bits[i + 3] == 1:
						counter_0001 = counter_0001 + 1
					elif bits[i] == 0 and bits[i + 1] == 0 and bits[i + 2] == 1 and bits[i + 3] == 0:
						counter_0010 = counter_0010 + 1
					elif bits[i] == 0 and bits[i + 1] == 0 and bits[i + 2] == 1 and bits[i + 3] == 1:
						counter_0011 = counter_0011 + 1
					elif bits[i] == 0 and bits[i + 1] == 1 and bits[i + 2] == 0 and bits[i + 3] == 0:
						counter_0100 = counter_0100 + 1
					elif bits[i] == 0 and bits[i + 1] == 1 and bits[i + 2] == 0 and bits[i + 3] == 1:
						counter_0101 = counter_0101 + 1
					elif bits[i] == 0 and bits[i + 1] == 1 and bits[i + 2] == 1 and bits[i + 3] == 0:
						counter_0110 = counter_0110 + 1
					elif bits[i] == 0 and bits[i + 1] == 1 and bits[i + 2] == 1 and bits[i + 3] == 1:
						counter_0111 = counter_0111 + 1
					elif bits[i] == 1 and bits[i + 1] == 0 and bits[i + 2] == 0 and bits[i + 3] == 0:
						counter_1000 = counter_1000 + 1
					elif bits[i] == 1 and bits[i + 1] == 0 and bits[i + 2] == 0 and bits[i + 3] == 1:
						counter_1001 = counter_1001 + 1
					elif bits[i] == 1 and bits[i + 1] == 0 and bits[i + 2] == 1 and bits[i + 3] == 0:
						counter_1010 = counter_1010 + 1
					elif bits[i] == 1 and bits[i + 1] == 0 and bits[i + 2] == 1 and bits[i + 3] == 1:
						counter_1011 = counter_1011 + 1
					elif bits[i] == 1 and bits[i + 1] == 1 and bits[i + 2] == 0 and bits[i + 3] == 0:
						counter_1100 = counter_1100 + 1
					elif bits[i] == 1 and bits[i + 1] == 1 and bits[i + 2] == 0 and bits[i + 3] == 1:
						counter_1101 = counter_1101 + 1
					elif bits[i] == 1 and bits[i + 1] == 1 and bits[i + 2] == 1 and bits[i + 3] == 0:
						counter_1110 = counter_1110 + 1
					elif bits[i] == 1 and bits[i + 1] == 1 and bits[i + 2] == 1 and bits[i + 3] == 1:
						counter_1111 = counter_1111 + 1

				# Counting propotion of "0000" substring
				propotions_of_0000.append(counter_0000 / (len(bits) - 3))
				# Counting propotion of "0001" substring
				propotions_of_0001.append(counter_0001 / (len(bits) - 3))
				# Counting propotion of "0010" substring
				propotions_of_0010.append(counter_0010 / (len(bits) - 3))
				# Counting propotion of "0011" substring
				propotions_of_0011.append(counter_0011 / (len(bits) - 3))
				# Counting propotion of "0100" substring
				propotions_of_0100.append(counter_0100 / (len(bits) - 3))
				# Counting propotion of "0101" substring
				propotions_of_0101.append(counter_0101 / (len(bits) - 3))
				# Counting propotion of "0110" substring
				propotions_of_0110.append(counter_0110 / (len(bits) - 3))
				# Counting propotion of "0111" substring
				propotions_of_0111.append(counter_0111 / (len(bits) - 3))
				# Counting propotion of "1000" substring
				propotions_of_1000.append(counter_1000 / (len(bits) - 3))
				# Counting propotion of "1001" substring
				propotions_of_1001.append(counter_1001 / (len(bits) - 3))
				# Counting propotion of "1010" substring
				propotions_of_1010.append(counter_1010 / (len(bits) - 3))
				# Counting propotion of "1011" substring
				propotions_of_1011.append(counter_1011 / (len(bits) - 3))
				# Counting propotion of "1100" substring
				propotions_of_1100.append(counter_1100 / (len(bits) - 3))
				# Counting propotion of "1101" substring
				propotions_of_1101.append(counter_1101 / (len(bits) - 3))
				# Counting propotion of "1110" substring
				propotions_of_1110.append(counter_1110 / (len(bits) - 3))
				# Counting propotion of "1111" substring
				propotions_of_1111.append(counter_1111 / (len(bits) - 3))
	
	# Passing and counting propotions
	pass_and_count(source)

	# Converting propotions to required form
	return numpy.asarray([propotions_of_0000, propotions_of_0001, propotions_of_0010, propotions_of_0011, \
 			propotions_of_0100, propotions_of_0101, propotions_of_0110, propotions_of_0111, \
			propotions_of_1000, propotions_of_1001, propotions_of_1010, propotions_of_1011, \
			propotions_of_1100, propotions_of_1101, propotions_of_1110, propotions_of_1111]).transpose()
