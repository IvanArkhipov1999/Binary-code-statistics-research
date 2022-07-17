from text_segment import text_segment
from pass_and_compile import numbered_pass_and_compile
from statistics import proportions_length_1


if __name__== "__main__":
#	print(text_segment("./test"))
#	numbered_pass_and_compile("./test", "./compile", "*.c", "g++", ["-std=gnu++11"])
#	numbered_pass_and_compile("../GCC/libstdc++-v3/testsuite", "../Binaries-dataset/x86_64-g++-ubuntu", "*.cc", "g++", ["-std=gnu++11", "-I../GCC/libstdc++-v3/testsuite/util"])
	print(proportions_length_1("./compile"))
