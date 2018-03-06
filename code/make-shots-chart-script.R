# ===================================================================
# Title: GSW players shot chart
# Description: This script performs to make GSW players' shot chart  
#              using several raw data file.
# Input(s): data file 'andre-iguodala.csv'
#                     'draymond-green.csv'
#                     'kevin-durant.csv'
#                     'klay-thompson.csv'
#                     'stephen-curry.csv'
# Output(s): data file'andre-iguodala-shot-chart.pdf'
#                     'draymond-green-shot-chart.pdf'
#                     'kevin-durant-shot-chart.pdf'
#                     'klay-thompson-shot-chart.pdf'
#                     'stephen-curry-shot-chart.pdf'
#                     
# Author(s): Minjeong Jeong
# Date: 03-05-2018
# ===================================================================

# packages
library(ggplot2)
library(jpeg)
library(grid)

# ===================================================================
# 4.1 scatter plot for Klay width:6.5 and height:5
# ===================================================================
court_file<-'../images/nba-court.jpg'
court_image<-rasterGrob(readJPEG(court_file),
                        width=unit(1,'npc'),
                        height=unit(1,'npc'))

thompson_shot_chart<-ggplot(data = thompson)+
               annotation_custom(court_image,-250,250,-50,420)+
               geom_point(aes(x=x,y=y,color=shot_made_flag))+
               ylim(-50,420)+
               ggtitle('Shot Chart : Klay Thompson (2016 season)')+
               theme_minimal()

ggsave('../images/klay-thompson-shot-chart.pdf', 
       plot = thompson_shot_chart,
       width = 6.5, height = 5, units = "in")

# ===================================================================
# 4.1 scatterplot for iguodala width:6.5 and height:5
# ===================================================================
iguodala_shot_chart<-ggplot(data= iguodala)+
      annotation_custom(court_image,-250,250,-50,420)+
      geom_point(aes(x=x,y=y,color=shot_made_flag))+
      ylim(-50,420)+
      ggtitle('Shot Chart : Andre Iguodala (2016 season)')+
      theme_minimal()

ggsave('../images/andre-iguodala-shot-chart.pdf', 
       plot = iguodala_shot_chart,
       width = 6.5, height = 5, units = "in")

# ===================================================================
# 4.1 scatterplot for green 
# ===================================================================
green_shot_chart<-ggplot(data= green)+
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart : Draymond Green (2016 season)')+
  theme_minimal()

ggsave('../images/draymond-green-shot-chart.pdf', 
       plot = green_shot_chart,
       width = 6.5, height = 5, units = "in")

# ===================================================================
# 4.1 scatterplot for kevin
# ===================================================================
durant_shot_chart <-ggplot(data= durant)+
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart : Kevin Durant (2016 season)')+
  theme_minimal()

ggsave('../images/kevin-durant-shot-chart.pdf', 
       plot = durant_shot_chart,
       width = 6.5, height = 5, units = "in")

# ===================================================================
# 4.1 scatterplot for curry
# ===================================================================
curry_shot_chart <- ggplot(data= curry)+
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart : Stephen Curry (2016 season)')+
  theme_minimal()

ggsave('../images/stephen-curry-shot-chart.pdf', 
       plot = curry_shot_chart,
       width = 6.5, height = 5, units = "in")


# ===================================================================
# 4.2 scatterplot for GSW shot 
# ===================================================================
gsw_shot_chart <- ggplot(data= shot_data)+
  annotation_custom(court_image,-250,250,-50,420)+
  geom_point(aes(x=x,y=y,color=shot_made_flag))+
  ylim(-50,420)+
  ggtitle('Shot Chart : GSW (2016 season)')+
  theme_minimal()+
  facet_wrap(~name)
  
ggsave('../images/gsw-shot-charts.pdf', 
       plot = gsw_shot_chart,
       width = 8, height = 7, units = "in")

# ===================================================================
# Description of the facetted shot chart
# ===================================================================
# The shot charts show the coordinates of the shots. 
# To be more meaningful, we add a background with the image of 
# basketball court. It tells where players throw the ball. 
# According to the chart, Curry had a lot of attempts at goal.
# Especially he threw lots of the ball at the 3 Point Line.
# Andre Iguodala and Green relatively had less attempts at goal.
# Through this shot chart, we can know the who had the most attempts at goal
# and where the player threw the ball (who is the 3pt shooter?).  

