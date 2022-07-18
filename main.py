from text_segment import *
from pass_and_compile import *
from statistics import *
from csv_local import *


if __name__== "__main__":
#	print(text_segment("./test"))
#	numbered_pass_and_compile("./test", "./compile", "*.c", "g++", ["-std=gnu++11"])
#	numbered_pass_and_compile("../GCC/libstdc++-v3/testsuite", "../Binaries-dataset/x86_64-g++-ubuntu", "*.cc", "g++", ["-std=gnu++11", "-I../GCC/libstdc++-v3/testsuite/util"])
#	write_data_to_csv("./data.csv", proportions_length_1("./compile"))
	add_data_to_csv("./data.csv", proportions_length_1("./compile"))
