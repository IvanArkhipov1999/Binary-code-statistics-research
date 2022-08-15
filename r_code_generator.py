
# -----------------------------------------------------------
# Generates R code for analysis of all binaries substrings of
# given length. Result is written in given file. 
#
# Parameters:
#
# file: path to file for writing R code
# length: length of substring
# -----------------------------------------------------------
def generate_code(file, length):
    the_file = open(file, 'w', encoding="utf-8")

    result = ""
    for i in range(2 ** length):
        # Generating substring
        substring = ""
        for j in range(length):
            substring = str(i % 2) + substring
            i = i // 2
            
        # Generating R code
        result = result + "to_hist_0_1(data$X" + substring + "..x86_64.g...ubuntu, \"" + substring + "\")\n"
        result = result + "to_hist_min_max(data$X" + substring + "..x86_64.g...ubuntu, \"" + substring + "\")\n"
        result = result + "to_hist_density(data$X" + substring + "..x86_64.g...ubuntu, \"" + substring + "\")\n"
        result = result + "ks_test_mle_norm(data$X" + substring + "..x86_64.g...ubuntu)\n"
        result = result + "ks_test_mle_gamma(data$X" + substring + "..x86_64.g...ubuntu)\n"
    
    the_file.write(result)
    the_file.close()
  