# Make Shots Data SCript ---------------------------------
# Description ---------------------------------
# In this R script files, I am creating a global table consisting information from players Andre Iguodala, Draymond Green, Klay Thompson, and Steph Curry.
# Inputs ---------------------------------
# The Inputs needed for this R script are the csv files in data.
# Outputs ---------------------------------
# The outputs of this R script are txt files in the folder outputs.



#Read in the five data sets
iguodala <- read.csv("/Users/madisontagg/Desktop/workout01/data/andre-iguodala.csv", stringsAsFactors = FALSE)
green <- read.csv("/Users/madisontagg/Desktop/workout01/data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("/Users/madisontagg/Desktop/workout01/data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("/Users/madisontagg/Desktop/workout01/data/klay-thompson.csv", stringsAsFactors = FALSE)
curry <- read.csv("/Users/madisontagg/Desktop/workout01/data/stephen-curry.csv", stringsAsFactors = FALSE)

#Adding a column name
library(dplyr)
iguodala <- mutate(iguodala, name = 'Andre Iguodala')
green <- mutate(green, name = 'Draymond Green')
durant <- mutate(durant, name = 'Kevin Durant')
thompson <- mutate(thompson, name = 'Klay Thompson')
curry <- mutate(curry, name = 'Stephen Curry')

#Changing the original values of shot_made_flag
iguodala[iguodala$shot_made_flag == 'y', ]$shot_made_flag <- 'shot_yes'
iguodala[iguodala$shot_made_flag == 'n', ]$shot_made_flag <- 'shot_no'

green[green$shot_made_flag == 'y', ]$shot_made_flag <- 'shot_yes'
green[green$shot_made_flag == 'n', ]$shot_made_flag <- 'shot_no'

durant[durant$shot_made_flag == 'y', ]$shot_made_flag <- 'shot_yes'
durant[durant$shot_made_flag == 'n', ]$shot_made_flag <- 'shot_no'

thompson[thompson$shot_made_flag == 'y', ]$shot_made_flag <- 'shot_yes'
thompson[thompson$shot_made_flag == 'n', ]$shot_made_flag <- 'shot_no'

curry[curry$shot_made_flag == 'y', ]$shot_made_flag <- 'shot_yes'
curry[curry$shot_made_flag == 'n', ]$shot_made_flag <- 'shot_no'

#adding column minute
iguodala <- mutate(iguodala, minute = iguodala$period * 12 - iguodala$minutes_remaining)
green <- mutate(green, minute = green$period * 12 - green$minutes_remaining)
durant <- mutate(durant, minute = durant$period * 12 - durant$minutes_remaining)
thompson <- mutate(thompson, minute = thompson$period * 12 - thompson$minutes_remaining)
curry <- mutate(curry, minute = curry$period * 12 - curry$minutes_remaining)

#using_sink to send summary() output
sink("/Users/madisontagg/Desktop/workout01/output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

sink("/Users/madisontagg/Desktop/workout01/output/draymond-green-summary.txt")
summary(green)
sink()

sink("/Users/madisontagg/Desktop/workout01/output/kevin-durant-summary.txt")
summary(durant)
sink()

sink("/Users/madisontagg/Desktop/workout01/output/klay-thompson-summary.txt")
summary(thompson)
sink()

sink("/Users/madisontagg/Desktop/workout01/output/stephen-curry-summary.txt")
summary(curry)
sink()


#row binding function rbind() to stack the tables into one single data frame
global_table <- data.frame(rbind(iguodala, green, durant, thompson, curry))
write.csv(global_table, "/Users/madisontagg/Desktop/workout01/data/shots-data.csv")

#Using sink to send summary()
sink("/Users/madisontagg/Desktop/workout01/output/shots-data-summary.txt")
summary(global_table)
sink()
