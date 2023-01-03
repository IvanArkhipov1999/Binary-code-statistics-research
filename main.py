from text_segment import *
from pass_and_compile import *
from statistics import *
from csv_local import *


if __name__== "__main__":
#	print(text_segment("../test86"))
#	print(text_segment("../test"))
#	print(text_segment("./compile/1"))
#	numbered_pass_and_compile("./test", "./compile", "*.c", "mips64el-linux-gnuabi64-g++", ["-std=gnu++11", "-march=mips64"])
#	numbered_pass_and_compile("./test", "./compile", "*.c", "g++", ["-std=gnu++11"])
#	write_data_to_csv("./data.csv", proportions_length("./compile", 1, "--arm64-g++-ubuntu"))
#	for i in range(2, 11):
#		add_data_to_csv("./data.csv", proportions_length("./compile", i, "--arm64-g++-ubuntu"))
#	numbered_pass_and_compile("../gcc/libstdc++-v3/testsuite", "../Binaries-dataset/arm-g++-ubuntu", "*.cc", "arm-linux-gnueabihf-g++", ["-std=gnu++11", "-I../gcc/libstdc++-v3/testsuite/util"])
#	numbered_pass_and_compile("../gcc/libstdc++-v3/testsuite", "../Binaries-dataset/arm64-g++-ubuntu", "*.cc", "aarch64-linux-gnu-g++", ["-std=gnu++11", "-I../gcc/libstdc++-v3/testsuite/util"])
#	numbered_pass_and_compile("../GCC/libstdc++-v3/testsuite", "../Binaries-dataset/x86_64-g++-ubuntu", "*.cc", "g++", ["-std=gnu++11", "-I../GCC/libstdc++-v3/testsuite/util"])
#	numbered_pass_and_compile("../gcc/libstdc++-v3/testsuite", "../Binaries-dataset/mips64el-g++-ubuntu", "*.cc", "mips64el-linux-gnuabi64-g++", ["-std=gnu++11", "-I../gcc/libstdc++-v3/testsuite/util", "-march=mips64"])
#	write_data_to_csv("./data_mips64el.csv", proportions_length("../Binaries-dataset/mips64el-g++-ubuntu", 1, "--mips64el-g++-ubuntu"))
	for i in range(2, 11):
		add_data_to_csv("./data_mips64el.csv", proportions_length("../Binaries-dataset/mips64el-g++-ubuntu", i, "--mips64el-g++-ubuntu"))
#	write_data_to_csv("./data.csv", proportions_length_1("../Binaries-dataset/x86_64-g++-ubuntu"))
#	write_data_to_csv("./data_arm64.csv", proportions_length("../Binaries-dataset/arm64-g++-ubuntu", 1))
#	add_data_to_csv("./data.csv", proportions_length_2("../Binaries-dataset/x86_64-g++-ubuntu"))
#	add_data_to_csv("./data_arm64.csv", proportions_length("../Binaries-dataset/arm64-g++-ubuntu", 2))
#	add_data_to_csv("./data_arm64.csv", proportions_length("../Binaries-dataset/arm64-g++-ubuntu", 3))
#	add_data_to_csv("./data_arm64.csv", proportions_length("../Binaries-dataset/arm64-g++-ubuntu", 4))
#	add_data_to_csv("./data_arm64.csv", proportions_length("../Binaries-dataset/arm64-g++-ubuntu", 5))
#	add_data_to_csv("./data_arm64.csv", proportions_length("../Binaries-dataset/arm64-g++-ubuntu", 6))
#	add_data_to_csv("./data_arm64.csv", proportions_length("../Binaries-dataset/arm64-g++-ubuntu", 7))
#	add_data_to_csv("./data_arm64.csv", proportions_length("../Binaries-dataset/arm64-g++-ubuntu", 8))
#	add_data_to_csv("./data_arm64.csv", proportions_length("../Binaries-dataset/arm64-g++-ubuntu", 9))
#	add_data_to_csv("./data_arm64.csv", proportions_length("../Binaries-dataset/arm64-g++-ubuntu", 10))
#	add_data_to_csv("./data.csv", proportions_length_3("../Binaries-dataset/x86_64-g++-ubuntu"))
#	add_data_to_csv("./data.csv", proportions_length_4("../Binaries-dataset/x86_64-g++-ubuntu"))
#	add_data_to_csv("./data.csv", proportions_length("../Binaries-dataset/x86_64-g++-ubuntu", 7))
#	add_data_to_csv("./data.csv", proportions_length("../Binaries-dataset/x86_64-g++-ubuntu", 8))
#	add_data_to_csv("./data.csv", proportions_length("../Binaries-dataset/x86_64-g++-ubuntu", 9))
#	write_data_to_csv("./data1.csv", proportions_length("./compile", 9))
