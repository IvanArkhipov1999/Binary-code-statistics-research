# Installing packages and including libraries
install.packages("dgof")
install.packages("brms")
install.packages("conf")
install.packages("useful")
library("dgof")
library("brms")
library("conf")
library("useful")

# Reading data
file <- "D:/Study/Диплом магистратура/Binary-code-statistics-research/data.csv"
data <- read.csv(file)

file <- "D:/Study/Диплом магистратура/Binary-code-statistics-research/data_arm64.csv"
data_arm64 <- read.csv(file)

file <- "D:/Study/Диплом магистратура/Binary-code-statistics-research/data_mips64el.csv"
data_mips64el <- read.csv(file)

# Setting number of files in dataset
size <- 3894
size_arm64 <- 3884
size_mips64el <- 3884

# -----------------------------------------------------------
# Generates hist for data_propotion with interval [0;1] and
# values of mean (Mean), standard deviation (Sd), median (Median),
# minimum (Min) and maximum (max).
#
# Parameters:
#
# data_propotion: column of propotions
# title: title of hist
# length: length for hist
# -----------------------------------------------------------
to_hist_0_1 <- function(data_propotion, title, length) {
  mean_prop <- mean(data_propotion)
  sd_prop <- sd(data_propotion)
  median_prop <- median(data_propotion)
  var_prop <- var(data_propotion)
  min_prop <- min(data_propotion)
  max_prop <- max(data_propotion)
  
  res <- hist(data_propotion, breaks = seq(min(0), max(1), length.out = length + 1)
              , main = title, xlab = "Propotions")
  
  text(max(res$breaks) * 0.82, max(res$counts), paste("Mean = ", mean_prop), cex = 0.75)
  text(max(res$breaks) * 0.82, max(res$counts) * 0.93, paste("Sd = ", sd_prop), cex = 0.75)
  text(max(res$breaks) * 0.82, max(res$counts) * 0.86, paste("Median = ", median_prop), cex = 0.75)
  text(max(res$breaks) * 0.82, max(res$counts) * 0.79, paste("Min = ", min_prop), cex = 0.75)
  text(max(res$breaks) * 0.82, max(res$counts) * 0.72, paste("Max = ", max_prop), cex = 0.75)
}

# -----------------------------------------------------------
# Generates hist for data_propotion with interval [min;max] and
# lines of mean and median. 
#
# Parameters:
#
# data_propotion: column of propotions
# title: title of hist
# length: length for hist
# -----------------------------------------------------------
to_hist_min_max <- function(data_propotion, title, length) {
  mean_prop <- mean(data_propotion)
  median_prop <- median(data_propotion)
  
  res <- hist(data_propotion, breaks = length, main = title, xlab = "Propotions")
  
  abline(v = mean_prop, col = "red", lwd = 2)
  abline(v = median_prop, col = "blue", lwd = 2)
  legend('topright', c('Mean', 'Median'), lty=1, col=c("red", "blue"))
}

# -----------------------------------------------------------
# Generates hist for data_propotion with interval [min;max],
# lines of mean, median and empirical density. 
#
# Parameters:
#
# data_propotion: column of propotions
# title: title of hist
# length: length for hist
# -----------------------------------------------------------
to_hist_density <- function(data_propotion, title, length) {
  mean_prop <- mean(data_propotion)
  median_prop <- median(data_propotion)
  density_data <- density(data_propotion)
  
  res <- hist(data_propotion, breaks = length, main = title, xlab = "Propotions"
              , ylim = range(0, max(density_data$y)))
  
  abline(v = mean_prop, col = "red", lwd = 2)
  abline(v = median_prop, col = "blue", lwd = 2)
  lines(density(data_propotion), col = "green3")
  
  legend('topright', c('Mean', 'Median', 'Density'), lty=1, col=c("red", "blue", "green3"))
}

# -----------------------------------------------------------
# Performs Kolmogorov-Smirnov test for data_propotion and
# norm distribution with parameters, that are counted with
# maximum likelihood estimation method. 
#
# Parameters:
#
# data_propotion: column of propotions
# -----------------------------------------------------------
ks_test_mle_norm <- function(data_propotion) {
  mean_prop <- mean(data_propotion)
  sd_prop <- sd(data_propotion)
  
  ks.test(data_propotion, "pnorm", mean_prop, sd_prop)
}

# -----------------------------------------------------------
# Performs Kolmogorov-Smirnov test for data_propotion and
# gamma distribution with parameters, that are counted with
# maximum likelihood estimation method. 
#
# Parameters:
#
# data_propotion: column of propotions
# -----------------------------------------------------------
ks_test_mle_gamma <- function(data_propotion) {
  gamma <- gammaMLE(data_propotion)$estimate
  ks.test(data_propotion, "pgamma", shape = gamma[1], scale = gamma[2])
}

# -----------------------------------------------------------
# Performs Kolmogorov-Smirnov test for all columns in data and
# norm distribution with parameters, that are counted with
# maximum likelihood estimation method. Prints all substring,
# on which Kolmogorov-Smirnov test has p.value > 0.05
#
# Parameters:
#
# data: data for analysis
# -----------------------------------------------------------
ks_test_mle_norm_analysis <- function(data) {
  i <- 1
  for (propotions in data) {
    p.value <- ks_test_mle_norm(propotions)$p.value
    if (p.value > 0.05) {
      length <- nchar(names(data[i]))
      substr <- substring(names(data[i]), 2, length - 19)
      print(paste(substr, ":", sep = ""))
      print(paste("p-value = ", p.value, sep = ""))
      print(paste("mu = ", mean(propotions), sep = ""))
      print(paste("sigma = ", sd(propotions), sep = ""))
    }
    i <- i + 1
  }
}

# -----------------------------------------------------------
# For all columns in data print substrings with min = 0.
#
# Parameters:
#
# data: data for analysis
# length: length of column in data
# -----------------------------------------------------------
zero_min_analysis <- function(data, length) {
  i <- 1
  count <- 0
  for (propotions in data) {
    min_prop <- min(propotions)
    mean_prop <- mean(propotions)
    if (min_prop == 0) {
      count <- count + 1
      length_str <- nchar(names(data[i]))
      substr <- substring(names(data[i]), 2, length_str - 17)
      print(paste(substr, ": Mean = ", mean_prop, " Zeroes = "
                  , sum(propotions == 0) * 100 / length, "%", sep = ""))
    }
    i <- i + 1
  }
  print(paste("Number of seq = ", count))
}

# -----------------------------------------------------------
# Performs Kolmogorov-Smirnov test for all columns in data1 and
# all columns in data2. Prints all substring,
# on which Kolmogorov-Smirnov test has p.value > 0.05
#
# Parameters:
#
# data1: data for analysis
# data2: data for analysis
# -----------------------------------------------------------
ks_test_for_datas_analysis <- function(data1, data2) {
  i <- 1
  for (propotions in data1) {
    p.value <- ks.test(as.numeric(unlist(data1[i])), as.numeric(unlist(data2[i])))$p.value
    if (p.value > 0.05) {
      length <- nchar(names(data[i]))
      substr <- substring(names(data[i]), 2, length - 19)
      print(paste(substr, ":", sep = ""))
      print(paste("p-value = ", p.value, sep = ""))
    }
    i <- i + 1
  }
}

# Content of zeroes analysis
zero_min_analysis(data, size)
zero_min_analysis(data_arm64, size_arm64)
zero_min_analysis(data_mips64el, size_mips64el)

# MLE norm distribution analysis
ks_test_mle_norm_analysis(data)
ks_test_mle_norm_analysis(data_arm64)
ks_test_mle_norm_analysis(data_mips64el)



# Analysis for x86_64 architecture

# Analysis of substrings with length 1
to_hist_0_1(data$X0..x86_64.g...ubuntu, "0", size)
to_hist_min_max(data$X0..x86_64.g...ubuntu, "0", size)
to_hist_density(data$X0..x86_64.g...ubuntu, "0", size)
ks_test_mle_norm(data$X0..x86_64.g...ubuntu)
to_hist_0_1(data$X1..x86_64.g...ubuntu, "1", size)
to_hist_min_max(data$X1..x86_64.g...ubuntu, "1", size)
to_hist_density(data$X1..x86_64.g...ubuntu, "1", size)
ks_test_mle_norm(data$X1..x86_64.g...ubuntu)

# Analysis of substrings with length 2
to_hist_0_1(data$X00..x86_64.g...ubuntu, "00", size)
to_hist_min_max(data$X00..x86_64.g...ubuntu, "00", size)
to_hist_density(data$X00..x86_64.g...ubuntu, "00", size)
ks_test_mle_norm(data$X00..x86_64.g...ubuntu)
to_hist_0_1(data$X01..x86_64.g...ubuntu, "01", size)
to_hist_min_max(data$X01..x86_64.g...ubuntu, "01", size)
to_hist_density(data$X01..x86_64.g...ubuntu, "01", size)
ks_test_mle_norm(data$X01..x86_64.g...ubuntu)
to_hist_0_1(data$X10..x86_64.g...ubuntu, "10", size)
to_hist_min_max(data$X10..x86_64.g...ubuntu, "10", size)
to_hist_density(data$X10..x86_64.g...ubuntu, "10", size)
ks_test_mle_norm(data$X10..x86_64.g...ubuntu)
to_hist_0_1(data$X11..x86_64.g...ubuntu, "11", size)
to_hist_min_max(data$X11..x86_64.g...ubuntu, "11", size)
to_hist_density(data$X11..x86_64.g...ubuntu, "11", size)
ks_test_mle_norm(data$X11..x86_64.g...ubuntu)

# Analysis of substrings with length 3
to_hist_0_1(data$X000..x86_64.g...ubuntu, "000", size)
to_hist_min_max(data$X000..x86_64.g...ubuntu, "000", size)
to_hist_density(data$X000..x86_64.g...ubuntu, "000", size)
ks_test_mle_norm(data$X000..x86_64.g...ubuntu)
to_hist_0_1(data$X001..x86_64.g...ubuntu, "001", size)
to_hist_min_max(data$X001..x86_64.g...ubuntu, "001", size)
to_hist_density(data$X001..x86_64.g...ubuntu, "001", size)
ks_test_mle_norm(data$X001..x86_64.g...ubuntu)
to_hist_0_1(data$X010..x86_64.g...ubuntu, "010", size)
to_hist_min_max(data$X010..x86_64.g...ubuntu, "010", size)
to_hist_density(data$X010..x86_64.g...ubuntu, "010", size)
ks_test_mle_norm(data$X010..x86_64.g...ubuntu)
to_hist_0_1(data$X011..x86_64.g...ubuntu, "011", size)
to_hist_min_max(data$X011..x86_64.g...ubuntu, "011", size)
to_hist_density(data$X011..x86_64.g...ubuntu, "011", size)
ks_test_mle_norm(data$X011..x86_64.g...ubuntu)
to_hist_0_1(data$X100..x86_64.g...ubuntu, "100", size)
to_hist_min_max(data$X100..x86_64.g...ubuntu, "100", size)
to_hist_density(data$X100..x86_64.g...ubuntu, "100", size)
ks_test_mle_norm(data$X100..x86_64.g...ubuntu)
to_hist_0_1(data$X101..x86_64.g...ubuntu, "101", size)
to_hist_min_max(data$X101..x86_64.g...ubuntu, "101", size)
to_hist_density(data$X101..x86_64.g...ubuntu, "101", size)
ks_test_mle_norm(data$X101..x86_64.g...ubuntu)
to_hist_0_1(data$X110..x86_64.g...ubuntu, "110", size)
to_hist_min_max(data$X110..x86_64.g...ubuntu, "110", size)
to_hist_density(data$X110..x86_64.g...ubuntu, "110", size)
ks_test_mle_norm(data$X110..x86_64.g...ubuntu)
to_hist_0_1(data$X111..x86_64.g...ubuntu, "111", size)
to_hist_min_max(data$X111..x86_64.g...ubuntu, "111", size)
to_hist_density(data$X111..x86_64.g...ubuntu, "111", size)
ks_test_mle_norm(data$X111..x86_64.g...ubuntu)


# Analysis for arm64 architecture

# Analysis of substrings with length 1
to_hist_0_1(data_arm64$X0..arm64.g...ubuntu, "0", size_arm64)
to_hist_min_max(data_arm64$X0..arm64.g...ubuntu, "0", size_arm64)
to_hist_density(data_arm64$X0..arm64.g...ubuntu, "0", size_arm64)
ks_test_mle_norm(data_arm64$X0..arm64.g...ubuntu)
to_hist_0_1(data_arm64$X1..arm64.g...ubuntu, "1", size_arm64)
to_hist_min_max(data_arm64$X1..arm64.g...ubuntu, "1", size_arm64)
to_hist_density(data_arm64$X1..arm64.g...ubuntu, "1", size_arm64)
ks_test_mle_norm(data_arm64$X1..arm64.g...ubuntu)

# Analysis of substrings with length 2
to_hist_0_1(data_arm64$X00..arm64.g...ubuntu, "00", size_arm64)
to_hist_min_max(data_arm64$X00..arm64.g...ubuntu, "00", size_arm64)
to_hist_density(data_arm64$X00..arm64.g...ubuntu, "00", size_arm64)
ks_test_mle_norm(data_arm64$X00..arm64.g...ubuntu)
to_hist_0_1(data_arm64$X01..arm64.g...ubuntu, "01", size_arm64)
to_hist_min_max(data_arm64$X01..arm64.g...ubuntu, "01", size_arm64)
to_hist_density(data_arm64$X01..arm64.g...ubuntu, "01", size_arm64)
ks_test_mle_norm(data_arm64$X01..arm64.g...ubuntu)
to_hist_0_1(data_arm64$X10..arm64.g...ubuntu, "10", size_arm64)
to_hist_min_max(data_arm64$X10..arm64.g...ubuntu, "10", size_arm64)
to_hist_density(data_arm64$X10..arm64.g...ubuntu, "10", size_arm64)
ks_test_mle_norm(data_arm64$X10..arm64.g...ubuntu)
to_hist_0_1(data_arm64$X11..arm64.g...ubuntu, "11", size_arm64)
to_hist_min_max(data_arm64$X11..arm64.g...ubuntu, "11", size_arm64)
to_hist_density(data_arm64$X11..arm64.g...ubuntu, "11", size_arm64)
ks_test_mle_norm(data_arm64$X11..arm64.g...ubuntu)

# Analysis of substrings with length 3
to_hist_0_1(data_arm64$X000..arm64.g...ubuntu, "000", size_arm64)
to_hist_min_max(data_arm64$X000..arm64.g...ubuntu, "000", size_arm64)
to_hist_density(data_arm64$X000..arm64.g...ubuntu, "000", size_arm64)
ks_test_mle_norm(data_arm64$X000..arm64.g...ubuntu)
to_hist_0_1(data_arm64$X001..arm64.g...ubuntu, "001", size_arm64)
to_hist_min_max(data_arm64$X001..arm64.g...ubuntu, "001", size_arm64)
to_hist_density(data_arm64$X001..arm64.g...ubuntu, "001", size_arm64)
ks_test_mle_norm(data_arm64$X001..arm64.g...ubuntu)
to_hist_0_1(data_arm64$X010..arm64.g...ubuntu, "010", size_arm64)
to_hist_min_max(data_arm64$X010..arm64.g...ubuntu, "010", size_arm64)
to_hist_density(data_arm64$X010..arm64.g...ubuntu, "010", size_arm64)
ks_test_mle_norm(data_arm64$X010..arm64.g...ubuntu)
to_hist_0_1(data_arm64$X011..arm64.g...ubuntu, "011", size_arm64)
to_hist_min_max(data_arm64$X011..arm64.g...ubuntu, "011", size_arm64)
to_hist_density(data_arm64$X011..arm64.g...ubuntu, "011", size_arm64)
ks_test_mle_norm(data_arm64$X011..arm64.g...ubuntu)
to_hist_0_1(data_arm64$X100..arm64.g...ubuntu, "100", size_arm64)
to_hist_min_max(data_arm64$X100..arm64.g...ubuntu, "100", size_arm64)
to_hist_density(data_arm64$X100..arm64.g...ubuntu, "100", size_arm64)
ks_test_mle_norm(data_arm64$X100..arm64.g...ubuntu)
to_hist_0_1(data_arm64$X101..arm64.g...ubuntu, "101", size_arm64)
to_hist_min_max(data_arm64$X101..arm64.g...ubuntu, "101", size_arm64)
to_hist_density(data_arm64$X101..arm64.g...ubuntu, "101", size_arm64)
ks_test_mle_norm(data_arm64$X101..arm64.g...ubuntu)
to_hist_0_1(data_arm64$X110..arm64.g...ubuntu, "110", size_arm64)
to_hist_min_max(data_arm64$X110..arm64.g...ubuntu, "110", size_arm64)
to_hist_density(data_arm64$X110..arm64.g...ubuntu, "110", size_arm64)
ks_test_mle_norm(data_arm64$X110..arm64.g...ubuntu)
to_hist_0_1(data_arm64$X111..arm64.g...ubuntu, "111", size_arm64)
to_hist_min_max(data_arm64$X111..arm64.g...ubuntu, "111", size_arm64)
to_hist_density(data_arm64$X111..arm64.g...ubuntu, "111", size_arm64)
ks_test_mle_norm(data_arm64$X111..arm64.g...ubuntu)


# Analysis for mips64el architecture

# Analysis of substrings with length 1
to_hist_0_1(data_mips64el$X0..mips64el.g...ubuntu, "0", size_mips64el)
to_hist_min_max(data_mips64el$X0..mips64el.g...ubuntu, "0", size_mips64el)
to_hist_density(data_mips64el$X0..mips64el.g...ubuntu, "0", size_mips64el)
ks_test_mle_norm(data_mips64el$X0..mips64el.g...ubuntu)
to_hist_0_1(data_mips64el$X1..mips64el.g...ubuntu, "1", size_mips64el)
to_hist_min_max(data_mips64el$X1..mips64el.g...ubuntu, "1", size_mips64el)
to_hist_density(data_mips64el$X1..mips64el.g...ubuntu, "1", size_mips64el)
ks_test_mle_norm(data_mips64el$X1..mips64el.g...ubuntu)

# Analysis of substrings with length 2
to_hist_0_1(data_mips64el$X00..mips64el.g...ubuntu, "00", size_mips64el)
to_hist_min_max(data_mips64el$X00..mips64el.g...ubuntu, "00", size_mips64el)
to_hist_density(data_mips64el$X00..mips64el.g...ubuntu, "00", size_mips64el)
ks_test_mle_norm(data_mips64el$X00..mips64el.g...ubuntu)
to_hist_0_1(data_mips64el$X01..mips64el.g...ubuntu, "01", size_mips64el)
to_hist_min_max(data_mips64el$X01..mips64el.g...ubuntu, "01", size_mips64el)
to_hist_density(data_mips64el$X01..mips64el.g...ubuntu, "01", size_mips64el)
ks_test_mle_norm(data_mips64el$X01..mips64el.g...ubuntu)
to_hist_0_1(data_mips64el$X10..mips64el.g...ubuntu, "10", size_mips64el)
to_hist_min_max(data_mips64el$X10..mips64el.g...ubuntu, "10", size_mips64el)
to_hist_density(data_mips64el$X10..mips64el.g...ubuntu, "10", size_mips64el)
ks_test_mle_norm(data_mips64el$X10..mips64el.g...ubuntu)
to_hist_0_1(data_mips64el$X11..mips64el.g...ubuntu, "11", size_mips64el)
to_hist_min_max(data_mips64el$X11..mips64el.g...ubuntu, "11", size_mips64el)
to_hist_density(data_mips64el$X11..mips64el.g...ubuntu, "11", size_mips64el)
ks_test_mle_norm(data_mips64el$X11..mips64el.g...ubuntu)

# Analysis of substrings with length 3
to_hist_0_1(data_mips64el$X000..mips64el.g...ubuntu, "000", size_mips64el)
to_hist_min_max(data_mips64el$X000..mips64el.g...ubuntu, "000", size_mips64el)
to_hist_density(data_mips64el$X000..mips64el.g...ubuntu, "000", size_mips64el)
ks_test_mle_norm(data_mips64el$X000..mips64el.g...ubuntu)
to_hist_0_1(data_mips64el$X001..mips64el.g...ubuntu, "001", size_mips64el)
to_hist_min_max(data_mips64el$X001..mips64el.g...ubuntu, "001", size_mips64el)
to_hist_density(data_mips64el$X001..mips64el.g...ubuntu, "001", size_mips64el)
ks_test_mle_norm(data_mips64el$X001..mips64el.g...ubuntu)
to_hist_0_1(data_mips64el$X010..mips64el.g...ubuntu, "010", size_mips64el)
to_hist_min_max(data_mips64el$X010..mips64el.g...ubuntu, "010", size_mips64el)
to_hist_density(data_mips64el$X010..mips64el.g...ubuntu, "010", size_mips64el)
ks_test_mle_norm(data_mips64el$X010..mips64el.g...ubuntu)
to_hist_0_1(data_mips64el$X011..mips64el.g...ubuntu, "011", size_mips64el)
to_hist_min_max(data_mips64el$X011..mips64el.g...ubuntu, "011", size_mips64el)
to_hist_density(data_mips64el$X011..mips64el.g...ubuntu, "011", size_mips64el)
ks_test_mle_norm(data_mips64el$X011..mips64el.g...ubuntu)
to_hist_0_1(data_mips64el$X100..mips64el.g...ubuntu, "100", size_mips64el)
to_hist_min_max(data_mips64el$X100..mips64el.g...ubuntu, "100", size_mips64el)
to_hist_density(data_mips64el$X100..mips64el.g...ubuntu, "100", size_mips64el)
ks_test_mle_norm(data_mips64el$X100..mips64el.g...ubuntu)
to_hist_0_1(data_mips64el$X101..mips64el.g...ubuntu, "101", size_mips64el)
to_hist_min_max(data_mips64el$X101..mips64el.g...ubuntu, "101", size_mips64el)
to_hist_density(data_mips64el$X101..mips64el.g...ubuntu, "101", size_mips64el)
ks_test_mle_norm(data_mips64el$X101..mips64el.g...ubuntu)
to_hist_0_1(data_mips64el$X110..mips64el.g...ubuntu, "110", size_mips64el)
to_hist_min_max(data_mips64el$X110..mips64el.g...ubuntu, "110", size_mips64el)
to_hist_density(data_mips64el$X110..mips64el.g...ubuntu, "110", size_mips64el)
ks_test_mle_norm(data_mips64el$X110..mips64el.g...ubuntu)
to_hist_0_1(data_mips64el$X111..mips64el.g...ubuntu, "111", size_mips64el)
to_hist_min_max(data_mips64el$X111..mips64el.g...ubuntu, "111", size_mips64el)
to_hist_density(data_mips64el$X111..mips64el.g...ubuntu, "111", size_mips64el)
ks_test_mle_norm(data_mips64el$X111..mips64el.g...ubuntu)
