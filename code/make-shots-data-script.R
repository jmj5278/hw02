# ===================================================================
# Title: GSW players shots data 
# Description: This script performs to make GSW players' shot   
#              using several raw data file.
# Input(s): data file 'andre-iguodala.csv'
#                     'draymond-green.csv'
#                     'kevin-durant.csv'
#                     'klay-thompson.csv'
#                     'stephen-curry.csv'
#                     'shot_data':assembeld table 
# Output(s): data file 'shots-data.csv'
#                     'andre-iguodala-summary.txt'
#                     'draymond-green-summary.txt'
#                     'kevin-durant-summary.txt'
#                     'klay-thompson-summary.txt'
#                     'stephen-curry-summary.txt'
#                     'shot_data-summary.txt'
# Author(s): Minjeong Jeong
# Date: 03-05-2018
# ===================================================================

# packages
library(readr)   
library(dplyr)


#Importing data
iguodala <- read.csv('../data/andre-iguodala.csv',stringsAsFactors = FALSE)
green <- read.csv('../data/draymond-green.csv',stringsAsFactors = FALSE)
durant <- read.csv('../data/kevin-durant.csv', stringsAsFactors = FALSE)
thompson<- read.csv('../data/klay-thompson.csv', stringsAsFactors = FALSE)
curry<- read.csv('../data/stephen-curry.csv', stringsAsFactors = FALSE)

#Added a column name
iguodala$name<- 'Andre iguodala'
green$name<- 'Draymond Green'
durant$name<-'Kevin Durant'
thompson$name<-'Klay Thompson'
curry$name<-'Stephen Curry'

#replace "n" and "y"
iguodala$shot_made_flag[iguodala$shot_made_flag == "n"] <-"missed shot"
iguodala$shot_made_flag[iguodala$shot_made_flag == "y"] <-"made shot"
green$shot_made_flag[green$shot_made_flag == 'n'] <-"missed shot"
green$shot_made_flag[green$shot_made_flag == 'y'] <-"made shot"
durant$shot_made_flag[durant$shot_made_flag == 'n'] <-"missed shot"
durant$shot_made_flag[durant$shot_made_flag == 'y'] <-'made shot'
thompson$shot_made_flag[thompson$shot_made_flag == 'n'] <-'missed shot'
thompson$shot_made_flag[thompson$shot_made_flag == 'y'] <-'made shot'
curry$shot_made_flag[curry$shot_made_flag == 'n'] <-'missed shot'
curry$shot_made_flag[curry$shot_made_flag == 'y'] <-'made shot'

#add minute
iguodala<-mutate(iguodala, minute = 12*(period)-minutes_remaining)
green<-mutate(green,minute = 12*(period)-minutes_remaining)
durant<-mutate(durant,minute = 12*(period)-minutes_remaining)
thompson<-mutate(thompson,minute = 12*(period)-minutes_remaining)
curry<-mutate(curry,minute = 12*(period)-minutes_remaining)

#summary of each data 
sink(file = '../output/andre-iguodala-summary.txt')
summary(iguodala)
sink()

sink(file = '../output/draymond-green-summary.txt')
summary(green)
sink()

sink(file = '../output/kevin-durant-summary.txt')
summary(durant)
sink()

sink(file ='../output/klay-thompson-summary.txt')
summary(thompson)
sink()

sink(file = '../output/stephen-curry-summary.txt')
summary(curry)
sink()

#binding and export the assembled table
shot_data<-rbind(iguodala,green,durant,thompson,curry)
write_csv(shot_data, path ='../data/shots-data.csv')

#summary of shot data
sink(file = '../output/shots-data-summary.txt')
summary(shot_data)
sink()
