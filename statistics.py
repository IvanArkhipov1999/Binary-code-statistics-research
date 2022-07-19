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

