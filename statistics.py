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
	propotions_of_0 = ["0"]
	# List with propotions of "1" substring
	propotions_of_1 = ["1"]

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

