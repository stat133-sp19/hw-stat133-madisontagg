# Title: Private Checker Functions
# Author: Madison Tagg
# Date: April 26, 2019
# Description: Code for all the private checker functions
# Private checker functions include the auxiliary functions: check_prob(), check_trials(), and check_success()


#1.1) Private Checker Functions


# Title: Probability Checker
# Description: Private auxiliary function to test if input prob is valid/invalid
# Input: One input, prob. prob = a probability value (valid if numeric value between 0 and 1)
# Returns: True if valid
check_prob <- function(prob) {
  if (class(prob) != "numeric" | length(prob) != 1){
    stop("Invalid Probability value")
  }
  else if (prob < 0 | prob > 1){
    stop("Probability has to be a number between 0 and 1")
  }
  return(TRUE)
}


# Title: Trails Checker
# Description: Private auxiliary function to test if input is a valid value for number of trails
# Input: One input, trials. Trials is a number, not negative.
# Returns: True if valid
check_trials <- function(trials) {
  if (trials <= 0 | trials %% 1 != 0){
    stop("Invalid trails value, must be larger than 0 and a whole number")
  }
  else if (length(trials) != 1){
    stop("Invalid trails value, must be the length of 1")
  }
  return(TRUE)
}


# Title: Success Checker
# Description: Private auxiliary function to test if an input success is a valid value for a number of successes
# Input: two inputs, success and trials. Success should be a vector of non-negative integer(s) less than or equal to trials.
# Returns: True if success is valid
check_success <- function(success, trials) {
  check_trials(trials)
  if (length(success) == 0 & class(success) == "integer"){
    return(TRUE)
  }
  for (i in 1:length(success)){
    if (success[i] < 0 | success[i] > trials | success[i] %% 1 != 0){
      stop("Invalid Success value")
    }
    else if (success[i] > trials) {
      stop('Success cannot be greater than trials')
    }
  }
  return(TRUE)
}
