from text_segment import *
from pass_and_compile import *
from statistics import *
from csv_local import *
from r_code_generator import *


if __name__== "__main__":
#	print(text_segment("./test"))
#	numbered_pass_and_compile("./test", "./compile", "*.c", "g++", ["-std=gnu++11"])
#	numbered_pass_and_compile("../GCC/libstdc++-v3/testsuite", "../Binaries-dataset/x86_64-g++-ubuntu", "*.cc", "g++", ["-std=gnu++11", "-I../GCC/libstdc++-v3/testsuite/util"])
#	write_data_to_csv("./data.csv", proportions_length_1("../Binaries-dataset/x86_64-g++-ubuntu"))
#	add_data_to_csv("./data.csv", proportions_length_2("../Binaries-dataset/x86_64-g++-ubuntu"))
#	add_data_to_csv("./data.csv", proportions_length_3("../Binaries-dataset/x86_64-g++-ubuntu"))
#	add_data_to_csv("./data.csv", proportions_length_4("../Binaries-dataset/x86_64-g++-ubuntu"))
#	add_data_to_csv("./data.csv", proportions_length("../Binaries-dataset/x86_64-g++-ubuntu", 7))
#	add_data_to_csv("./data.csv", proportions_length("../Binaries-dataset/x86_64-g++-ubuntu", 8))
#	add_data_to_csv("./data.csv", proportions_length("../Binaries-dataset/x86_64-g++-ubuntu", 9))
#	write_data_to_csv("./data1.csv", proportions_length("./compile", 9))
    generate_code('code.txt', 10)
