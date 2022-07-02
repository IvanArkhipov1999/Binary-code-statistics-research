import os
import fnmatch
import random


# -----------------------------------------------------------
# Passes through given source directory and it's subdirectories,
# compiles with given compiler and flags all finded files with given pattern
# and puts binaries in given directory for compiled files. Compiled files have
# random names.
#
# Parameters:
#
# source: path to directory with source files for compiling
# compiled: path to directory for putting compiled files
# pattern: regular expression for name of source files. For example, "*.c"
# compiler: compiler for compiling
# flags: list of flags for compiling
# -----------------------------------------------------------
# FIXME try to divide it in to functions: pass with function parameter and compile
def pass_and_compile(source, compiled, pattern, compiler, flags):
	# Passing through all subdirectories
	for subdir in os.listdir(source):
		# Getting subdirectory's path
		path_to_subdir = source + "/" + subdir

		# If it is subdirectory then call this function
		if os.path.isdir(path_to_subdir):
			pass_and_compile(path_to_subdir, compiled, pattern, compiler, flags)
		# If it is file with given pattern then compile
		elif fnmatch.fnmatch(subdir, pattern):
			# Setting compiler
			compiling_command = compiler + " "
			# Setting flags
			for flag in flags:
				compiling_command = compiling_command + flag + " "
			# Setting path to source file
			compiling_command = compiling_command + path_to_subdir + " -o "
			# Setting path for binary file
			compiling_command = compiling_command + compiled + "/" + str(random.randint(0, 1000000000)) + " "
			# Removing output
			compiling_command = compiling_command + "2> /dev/null"
			# Executing command
			os.system(compiling_command)


