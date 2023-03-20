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
  x2 <- seq(0, 1, length = length)
  fun <- dnorm(x2, mean = mean_prop, sd = sd_prop)
  lines(x2, fun, col = 2, lwd = 2)
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
# Generates hist for data_propotion with interval [min;max],
# curve of normal distibution with parameters 
# obtained by the maximum likelihood method and given p-value. 
#
# Parameters:
#
# data_propotion: column of propotions
# title: title of hist
# length: length for hist
# p_value: p-value
# -----------------------------------------------------------
to_hist_min_max_norm <- function(data_propotion, title, length, p_value) {
  mean_prop <- mean(data_propotion)
  sd_prop <- sd(data_propotion)
  median_prop <- median(data_propotion)
  var_prop <- var(data_propotion)
  min_prop <- min(data_propotion)
  max_prop <- max(data_propotion)
  
  res <- hist(data_propotion, breaks = 7, main = title, xlab = "Propotions")
  
  text(max(res$breaks) * 0.82, max(res$counts), paste("Mean = ", mean_prop), cex = 0.75)
  text(max(res$breaks) * 0.82, max(res$counts) * 0.93, paste("Sd = ", sd_prop), cex = 0.75)
  text(max(res$breaks) * 0.82, max(res$counts) * 0.86, paste("p.value = ", p_value), cex = 0.75)

  x2 <- seq(0, 0.1, length = length)
  fun <- dnorm(x2, mean = mean_prop, sd = sd_prop)
  lines(x2, fun, col = 2, lwd = 2)
}


# -----------------------------------------------------------
# Generates hist for data_propotion with interval [min;max],
# and given propotion of files without sequence. 
#
# Parameters:
#
# data_propotion: column of propotions
# title: title of hist
# length: length for hist
# propotion: propotion of files without sequence
# -----------------------------------------------------------
to_hist_min_max_zero <- function(data_propotion, title, length, propotion) {
  mean_prop <- mean(data_propotion)
  sd_prop <- sd(data_propotion)
  median_prop <- median(data_propotion)
  var_prop <- var(data_propotion)
  min_prop <- min(data_propotion)
  max_prop <- max(data_propotion)
  
  res <- hist(data_propotion, breaks = length, main = title, xlab = "Propotions")
  
  text(max(res$breaks) * 0.82, max(res$counts), paste("Mean = ", mean_prop), cex = 0.75)
  text(max(res$breaks) * 0.82, max(res$counts) * 0.93, paste("Sd = ", sd_prop), cex = 0.75)
  text(max(res$breaks) * 0.82, max(res$counts) * 0.86, paste("Propotion = ", propotion, "%"), cex = 0.75)
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
      substr <- substring(names(data[i]), 2, length - 17)
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


# Histograms with normal distribution
to_hist_min_max_norm(data$X10000110..x86_64.g...ubuntu, "10000110", size, 0.128037147742374)
to_hist_min_max_norm(data$X11100001..x86_64.g...ubuntu, "11100001", size, 0.14791676250976)
to_hist_min_max_norm(data$X11100101..x86_64.g...ubuntu, "11100101", size, 0.107025294099523)
to_hist_min_max_norm(data$X110010101..x86_64.g...ubuntu, "110010101", size, 0.14805449729312)
to_hist_min_max_norm(data$X0101000000..x86_64.g...ubuntu, "0101000000", size, 0.255080488015968)
to_hist_min_max_norm(data$X1001111001..x86_64.g...ubuntu, "1001111001", size, 0.100419423312174)

to_hist_min_max_norm(data_arm64$X11101..arm64.g...ubuntu, "11101", size_arm64, 0.0722909006726833)
to_hist_min_max_norm(data_arm64$X111010..arm64.g...ubuntu, "111010", size_arm64, 0.217585052057412)
to_hist_min_max_norm(data_arm64$X0010011..arm64.g...ubuntu, "0010011", size_arm64, 0.502435966536002)
to_hist_min_max_norm(data_arm64$X10001001..arm64.g...ubuntu, "10001001", size_arm64, 0.249268989875839)
to_hist_min_max_norm(data_arm64$X111111010..arm64.g...ubuntu, "111111010", size_arm64, 0.0767739863208129)
to_hist_min_max_norm(data_arm64$X1111000010..arm64.g...ubuntu, "1111000010", size_arm64, 0.139639519995891)

to_hist_min_max_norm(data_mips64el$X0011100..mips64el.g...ubuntu, "0011100", size_mips64el, 0.185159480690799)
to_hist_min_max_norm(data_mips64el$X011000010..mips64el.g...ubuntu, "011000010", size_mips64el, 0.142659235812227)
to_hist_min_max_norm(data_mips64el$X111100011..mips64el.g...ubuntu, "111100011", size_mips64el, 0.279767720829936)
to_hist_min_max_norm(data_mips64el$X0011000010..mips64el.g...ubuntu, "0011000010", size_mips64el, 0.111278735570225)
to_hist_min_max_norm(data_mips64el$X1111001000..mips64el.g...ubuntu, "1111001000", size_mips64el, 0.0735398060142192)
to_hist_min_max_norm(data_mips64el$X1111100011..mips64el.g...ubuntu, "1111100011", size_mips64el, 0.152682822326079)

# Histograms with zeroes propotions
to_hist_min_max_zero(data$X10000110..x86_64.g...ubuntu, "10110100", size, 0.333846944016436)
to_hist_min_max_zero(data$X11100110..x86_64.g...ubuntu, "11100110", size, 15.6137647663071)
to_hist_min_max_zero(data$X110101100..x86_64.g...ubuntu, "110101100", size, 3.87776065742167)
to_hist_min_max_zero(data$X111001101..x86_64.g...ubuntu, "111001101", size, 45.9167950693374)
to_hist_min_max_zero(data$X1111001101..x86_64.g...ubuntu, "1111001101", size, 65.1001540832049)
to_hist_min_max_zero(data$X1111111011..x86_64.g...ubuntu, "1111111011", size, 0.025680534155)

to_hist_min_max_zero(data_arm64$X00110011..arm64.g...ubuntu, "00110011", size_arm64, 9.75860297894196)
to_hist_min_max_zero(data_arm64$X11001101..arm64.g...ubuntu, "11001101", size_arm64, 0.02568053415511)
to_hist_min_max_zero(data_arm64$X010000110..arm64.g...ubuntu, "010000110", size_arm64, 4.31432973805855)
to_hist_min_max_zero(data_arm64$X110110010..arm64.g...ubuntu, "110110010", size_arm64, 36.9542886492039)
to_hist_min_max_zero(data_arm64$X1011011101..arm64.g...ubuntu, "1011011101", size_arm64, 68.0790960451977)
to_hist_min_max_zero(data_arm64$X1111001101..arm64.g...ubuntu, "1111001101", size_arm64, 0.102722136620442)

to_hist_min_max_zero(data_mips64el$X10011010..mips64el.g...ubuntu, "10011010", size_mips64el, 19.5159629248198)
to_hist_min_max_zero(data_mips64el$X10101101..mips64el.g...ubuntu, "10101101", size_mips64el, 49.6652935118435)
to_hist_min_max_zero(data_mips64el$X000011101..mips64el.g...ubuntu, "000011101", size_mips64el, 0.772399588053553)
to_hist_min_max_zero(data_mips64el$X011111101..mips64el.g...ubuntu, "011111101", size_mips64el, 5.14933058702369)
to_hist_min_max_zero(data_mips64el$X1010101101..mips64el.g...ubuntu, "1010101101", size_mips64el, 93.4603501544799)
to_hist_min_max_zero(data_mips64el$X1100110010..mips64el.g...ubuntu, "1100110010", size_mips64el, 10.4531410916581)
