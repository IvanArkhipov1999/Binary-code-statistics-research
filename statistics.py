import os
import numpy

from text_segment import text_segment


# -----------------------------------------------------------
# Passes through given source directory and it's subdirectories,
# for each file counts propotion of each binary substring with given length.
# Returns numpy array with propotions. Each column of numpy array contains
# propotions of certain substring for all files. Substrings arranged 
# in lexicographic order.
#
# Parameters:
#
# source: path to directory with executable binary files
# length: length of substring
# -----------------------------------------------------------
def proportions_length(source, length):
	result_propotions = {}

	# Passing and counting propotions function
	def pass_and_count(source, length):
		nonlocal result_propotions

		# Passing through all subdirectories
		for subdir in os.listdir(source):
			# Getting subdirectory's path
			path_to_subdir = source + "/" + subdir

			# If it is subdirectory then call this function
			if os.path.isdir(path_to_subdir):
				pass_and_count(path_to_subdir, length)
			# If it is file
			else:
				# Printing file name
				print(path_to_subdir)
				# Getting text segment in bytes
				bytes = text_segment(path_to_subdir)
				# Converting text segment to bits
				bits = numpy.unpackbits(bytes)

				# Dictionary of propotions in file
				propotions = {}

				# Cycle throuth bits for counting substrings
				for i in range(0, len(bits) - length + 1):
					# Forming key based on substring
					substr_key = ""
					for bit in bits[i : i + length]:
						substr_key = substr_key + str(bit)

					substr_key = substr_key + "--arm64-g++-ubuntu"

					# Adding or incrementing value for formed key
					if substr_key not in propotions:
						propotions.update({substr_key : 1})
					else:
						propotions.update({substr_key : propotions.get(substr_key) + 1})

				# If there was not substring in file, propotion is zero
				for i in range(2**length):
					substring = ""
					for j in range(length):
						substring = str(i % 2) + substring
						i = i // 2
					substring_key = substring + "--arm64-g++-ubuntu"
					if substring_key not in propotions:
						propotions.update({substring_key : 0})

				# Adding propotions to results
				for key in propotions:
					if key not in result_propotions:
						result_propotions.update({key : [propotions.get(key) / (len(bits) - length + 1)]})
					else:
						new_results = result_propotions.get(key)
						new_results.append(propotions.get(key) / (len(bits) - length + 1))
						result_propotions.update({key : new_results})

	# Passing and counting propotions
	pass_and_count(source, length)

	# Converting result to numpy array
	final_result = []
	for element in list(result_propotions.items()):
		list_element = element[1]
		list_element.insert(0, element[0])
		final_result.append(list_element)
	unsorted_result = numpy.array(final_result, dtype="object").transpose()

	# Sorting result by first row
	sorted_result = unsorted_result[:, unsorted_result[0, :].argsort()]
	return sorted_result
