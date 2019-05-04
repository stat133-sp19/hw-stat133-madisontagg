# Title: Main Functions and Methods
# Author: Madison Tagg
# Date: April 26, 2019
# Description: Code for all the main functions
# Main functions include the functions: bin_choose(), bin_probability(), bin_distribution(); and plot.bindis()
#   bin_cumulative(); and plot.bincum(), bin_var(); print.binvar(), summary.binvar(), print.summary.binvar()
#   bin_mean(), bin_varianve(), bin_mode(), bin_skewness(), bin_kurtosis()



#1.3) Function bin_choose()

#' @title Binomial Choose Main Function
#' @description calculates the number of combinations in which k successes can occur in n trials
#' @param n number of trials - numeric
#' @param k number of successes - numeric
#' @return a number of combinations - numeric
#' @export
#' @examples
#' bin_choose(n = 5, k = 2)
#' bin_choose(5, 0)
#' bin_choose(5, 1:3)

bin_choose <- function(n, k){
  if (k > n){
    stop("k cannon be greater than n")
  }
  if (k < 0 | n < 0){
    stop("input cannot be negative")
  }
  n_fact <- factorial(n)
  k_fact <- factorial(k)
  return(n_fact/(k_fact*factorial(n-k)))
}






#1.4) Function bin_probability()

#' @title Binomial Probability Main Function
#' @description compute the binomial probabilities based on the success, independent trials and probability
#' @param trials number of trials - numeric
#' @param success number of successes - numeric
#' @param prob probability of each trial (more than 0 and less than 1)
#' @return a probability of the binomial
#' @export
#' @examples
#' bin_probability(success = 2, trials = 5, prob = 0.5)
#' bin_probability(success = 0:2, trials = 5, prob = 0.5)
#' bin_probability(success = 55, trials = 100, prob = 0.45)

bin_probability <- function(success, trials, prob){
  check_prob(prob)
  check_trials(trials)
  check_success(success, trials)
  return_array <- c()
  for (i in 1:length(success)){
    b <- bin_choose(trials, success[i])
    p <- prob^(success[i])
    not_p <- (1-prob)^(trials-success[i])
    bin_prob <- b*p*not_p
    return_array <- c(return_array, bin_prob)}
  return(return_array)
}






#1.5) Function bin_distribution()

#' @title Binomial Distribution Main Function
#' @description computes a data frame with the probability distribution: sucesses in the first column, prob in the second
#' @param trials number of trials - numeric
#' @param prob probability of each trial (more than 0 and less than 1)
#' @return a data.frame with two classes: c("bindis", "data.frame")
#' @export
#' @examples
#' bin_distribution(trials = 5, prob = 0.5)

bin_distribution <- function(trials, prob){
  df <- setNames(data.frame(matrix(ncol = 2, nrow = trials+1)), c("success", "probability"))
  for (i in 0:trials){
    df[i+1,1] <- i
    df[i+1,2] <- bin_probability(i, trials, prob)
  }
  class(df) <- c("bindis", "data.frame")
  return(df)
}


# plot.bindis() is a method that graphs a barplot to display prob histogram of binomial distribution
#' @import ggplot2
#' @export
#' @examples
#' dis1 <- bin_distribution(trials = 5, prob = 0.5)
#' plot(dis1)

plot.bindis <- function(distrib){
  ggplot(distrib, aes(x = success, y = probability)) +
    ggtitle("Barplot Display of the Probability Histogram") +
    xlab("successes") +
    ylab("probability") +
    geom_col(fill= "grey") +
    theme_minimal()
}






#1.6) Function bin_cumulative()

#' @title Binomial Cumulative Main Function
#' @description computes a data frame with the probability distribution along with cumulative probability: sucesses in the first column, prob in the second
#' @param trials number of trials - numeric
#' @param prob probability of each trial (more than 0 and less than 1)
#' @return a data.frame with two classes: c("bincum", "data.frame")
#' @export
#' @examples
#' bin_cumulative(trials = 5, prob = 0.5)

bin_cumulative <- function(trials, prob){
  cdf <- setNames(data.frame(matrix(ncol = 3, nrow = trials+1)), c("success", "probability", "cumulative"))
  cum_value = 0
  for (i in 0:trials){
    cum_value = cum_value + bin_probability(i, trials, prob)
    cdf[i+1, 1] <- i
    cdf[i+1, 2] <- bin_probability(i, trials, prob)
    cdf[i+1, 3] <- cum_value}
  class(cdf) <- c("bincum", "data.frame")
  return(cdf)
}


# plot.bincum() is a method that graphs the cumulative distribution
#' @import ggplot2
#' @export
#' @examples
#' dis2 <- bin_cumulative(trials = 5, prob = 0.5)
#' plot(dis2)

plot.bincum <- function(distrib){
  ggplot(distrib, aes(x = success, y = cumulative)) +
    ggtitle("Linegraph Display of the Probability Histogram") +
    xlab("successes") +
    ylab("probability") + theme_classic() +
    geom_line() + geom_point(shape = 21, colour = "black", fill = "white", size = 2)
}





#1.7) Function bin_variable()

#' @title Binomial Variable Main Function
#' @description computes an object of class "binvar", a binomial random variable object
#' @param trials number of trials - numeric
#' @param prob probability of each trial (more than 0 and less than 1)
#' @return an object that should be a list with named elements: trials, probs
#' @export

bin_variable <- function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  bv <- c(trials, prob)
  class(bv) <- c("binvar")
  return(bv)
}


# Printing the bin_variable object
#' @export
#' @example
#' bin1 <- bin_variable(trials = 10, p = 0.3)
#' bin1

print.binvar <- function(bv){
  print("Binomial variable")
  print(" ", quote=FALSE)
  print('Paramaters', quote=FALSE)
  print(paste0("- number of trials: ", bv[1]), quote = FALSE)
  print(paste0("- prob of success : ", bv[2]), quote = FALSE)
}


# Full summary of the bin_variable object "binvar"
#' @export
#' @example
#' bin1 <- bin_variable(trials = 10, p = 0.3)
#' summary(bin1)

summary.binvar <- function(bv){
  bv_trials <- bv[1]
  bv_prob <- bv[2]
  summary_vec <- c(bv_trials, bv_prob, aux_mean(bv_trials, bv_prob), aux_variance(bv_trials, bv_prob)
               , aux_mode(bv_trials, bv_prob), aux_skewness(bv_trials, bv_prob), aux_kurtosis(bv_trials, bv_prob))
  names(summary_vec) <- c("trials", "probability", "mean", "variance", "mode", "skewness", "kurtosis")
  class(summary_vec) <- c("summary.binvar")
  return(summary_vec)
}


# Printing of summary binvar object
#' @export
#' @example
#' bin1 <- bin_variable(trials = 10, p = 0.3)
#' binsum1 <- summary(bin1)
#' binsum1

print.summary.binvar <- function(binv){
  print("Summary Binomial")
  print(" ", quote=FALSE)
  print('Paramaters', quote=FALSE)
  print(paste0("- number of trials: ", binv[1]), quote = FALSE)
  print(paste0("- prob of success : ", binv[2]), quote = FALSE)
  print(" ", quote=FALSE)
  print('Measures', quote=FALSE)
  print(paste0("- mean    : ", binv[3]), quote = FALSE)
  print(paste0("- variance: ", binv[4]), quote = FALSE)
  print(paste0("- mode    : ", binv[5]), quote = FALSE)
  print(paste0("- skewness: ", binv[6]), quote = FALSE)
  print(paste0("- kurtosis: ", binv[7]), quote = FALSE)
}






#1.8) Functions of measures

#' @title Binomial Mean Function
#' @description computes the mean of binomial distribution
#' @param trials number of trials - numeric
#' @param prob probability of each trial (more than 0 and less than 1)
#' @return the mean of binomial distribution
#' @export
#' @examples
#' bin_mean(10, 0.3)

bin_mean <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_mean(trials, prob))
}


#' @title Binomial Variance Function
#' @description computes the variance of binomial distribution
#' @param trials number of trials - numeric
#' @param prob probability of each trial (more than 0 and less than 1)
#' @return the variance of binomial distribution
#' @export
#' @examples
#' bin_variance(10, 0.3)

bin_variance <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_variance(trials, prob))
}


#' @title Binomial Mode Function
#' @description computes the mode of binomial distribution
#' @param trials number of trials - numeric
#' @param prob probability of each trial (more than 0 and less than 1)
#' @return the mode of binomial distribution
#' @export
#' @examples
#' bin_mode(10, 0.3)

bin_mode <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_mode(trials, prob))
}


#' @title Binomial Skewness Function
#' @description computes the skewness of binomial distribution
#' @param trials number of trials - numeric
#' @param prob probability of each trial (more than 0 and less than 1)
#' @return the skewness of binomial distribution
#' @export
#' @examples
#' bin_skewness(10, 0.3)

bin_skewness <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_skewness(trials, prob))
}


#' @title Binomial Kurtosis Function
#' @description computes the kurtosis of binomial distribution
#' @param trials number of trials - numeric
#' @param prob probability of each trial (more than 0 and less than 1)
#' @return the kurtosis of binomial distribution
#' @export
#' @examples
#' bin_kurtosis(10, 0.3)

bin_kurtosis <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_kurtosis(trials, prob))
}

