# Title: Private Auxiliary Functions
# Author: Madison Tagg
# Date: April 26, 2019
# Description: Code for all the private auxiliary functions
# Private auxiliary functions include the functions: aux_mean(), aux_variance(), aux_mode(), aux_skewness(), aux_kurtosis



#1.2) Private Auxiliary Functions

# Title: Aux Mean
# Description: Private auxiliary function to return the mean of the trials based on the probability
# Input: two inputs, trials and prob.
# Returns: corresponding numeric value
aux_mean <- function(trials, prob){
  if (prob < 0 | prob > 1){
    stop("Prob is a invalid input")
  }
  else if (trials < 0){
    stop("trials must be positive")
  }
  n <- trials
  p <- prob
  return(n*p)
}


# Title: Aux Variance
# Description: Private auxiliary function to return the variance of the trials based on the probability
# Input: two inputs, trials and prob.
# Returns: corresponding numeric value
aux_variance <- function(trials, prob){
  if (prob < 0 | prob > 1){
    stop("Prob is a invalid input")
  }
  n <- trials
  p <- prob
  return(aux_mean(n, p) * (1-prob))
}


# Title: Aux Mode
# Description: Private auxiliary function that finds the most likely number of success in n independent trials based on the probability of success on each trial
# Input: two inputs, trials and prob.
# Returns: corresponding mode of the binomial distribution
aux_mode <- function(trials, prob){
  if (prob < 0 | prob > 1){
    stop("Prob is a invalid input")
  }
  n <- trials
  p <- prob
  m <- aux_mean(n, p) + p
  if (m %% 1 == 0){
    return(c(m, m-1))
  }
  return(as.integer(m))
}


# Title: Aux Skewness
# Description: Private auxiliary function that measures the asymmetry of the probability distribution of a random variable about its mean
# Input: two inputs, trials and prob.
# Returns: corresponding skewness of a binomial random variable (can be positive, negative, or undefined), numeric
aux_skewness <- function(trials, prob){
  if (prob < 0 | prob > 1 ){
    stop("Prob is a invalid input")
  }
  n <- trials
  p <- prob
  return((1-2*p)/sqrt(aux_mean(n, p)*(1-p)))
}


# Title: Aux Kurtosis
# Description: Private auxiliary function that measures the "tailedness" of the probability distribution of a random variable
# Input: two inputs, trials and prob.
# Returns: corresponding kurtosis of a binomial random variable, numeric
aux_kurtosis <- function(trials, prob){
  if (prob < 0 | prob > 1){
    stop("Prob is a invalid input")
  }
  n <- trials
  p <- prob
  nom <- 1 - ((6*p)*(1-p))
  denom <- aux_mean(n,p)*(1-p)
  return(nom/denom)
}

