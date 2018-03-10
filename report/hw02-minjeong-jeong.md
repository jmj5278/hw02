hw02-minjoeng-jeong
================
Minjeong Jeong
2018-03-05

### setting up

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(ggplot2)
source('../code/make-shots-data-script.R')
```

5)summary tables
================

5.1) Total Shots by player

``` r
#Total shots by player
Total_Shot<- shot_data %>%
             select(shot_type, name) %>%
             group_by(name) %>% 
             summarise(total=length(shot_type)) %>%
             arrange(desc(total))

Total_Shot
```

    ## # A tibble: 5 x 2
    ##   name           total
    ##   <chr>          <int>
    ## 1 Stephen Curry   1250
    ## 2 Klay Thompson   1220
    ## 3 Kevin Durant     915
    ## 4 Draymond Green   578
    ## 5 Andre iguodala   371

5.2) Effective shooting Percentage

``` r
#Effective shooting percentage
eff_shot_per<-shot_data %>%
               group_by(name) %>%
             summarise(total_shots = length(shot_type), 
                       made_shots =  sum(shot_made_flag == "made shot"), 
                       percent_shot = made_shots/total_shots) %>%
             arrange(desc(percent_shot))
eff_shot_per
```

    ## # A tibble: 5 x 4
    ##   name           total_shots made_shots percent_shot
    ##   <chr>                <int>      <int>        <dbl>
    ## 1 Kevin Durant           915        495        0.541
    ## 2 Andre iguodala         371        192        0.518
    ## 3 Klay Thompson         1220        575        0.471
    ## 4 Stephen Curry         1250        584        0.467
    ## 5 Draymond Green         578        245        0.424

``` r
#2PT Effective shooting percentage
two_shot_per<-shot_data %>%
               group_by(name) %>%
               summarise(total_two_point= sum(shot_type == "2PT Field Goal"),
               made_two_point = sum(shot_made_flag == "made shot" & shot_type == "2PT Field Goal"),
               percent_two_point = made_two_point/total_two_point) %>%
               arrange(desc(percent_two_point))
two_shot_per
```

    ## # A tibble: 5 x 4
    ##   name           total_two_point made_two_point percent_two_point
    ##   <chr>                    <int>          <int>             <dbl>
    ## 1 Andre iguodala             210            134             0.638
    ## 2 Kevin Durant               643            390             0.607
    ## 3 Stephen Curry              563            304             0.540
    ## 4 Klay Thompson              640            329             0.514
    ## 5 Draymond Green             346            171             0.494

``` r
#3PT Effective shooting percentage
three_shot_per<-shot_data %>%
                group_by(name)%>%
                summarise(total_three_point = sum(shot_type == "3PT Field Goal"),
                          made_three_point = sum(shot_made_flag== "made shot" & shot_type == '3PT Field Goal'),
                          percent_three_point = made_three_point/total_three_point) %>%
                arrange(desc(percent_three_point))
three_shot_per
```

    ## # A tibble: 5 x 4
    ##   name           total_three_point made_three_point percent_three_point
    ##   <chr>                      <int>            <int>               <dbl>
    ## 1 Klay Thompson                580              246               0.424
    ## 2 Stephen Curry                687              280               0.408
    ## 3 Kevin Durant                 272              105               0.386
    ## 4 Andre iguodala               161               58               0.360
    ## 5 Draymond Green               232               74               0.319

6)shooting distance
===================

6.1) dplyr table

``` r
made_shot_prop<-shot_data %>%
                group_by(shot_distance)%>%
                summarise(made_shot_prop = (sum(shot_made_flag == 'made shot'))/length(shot_made_flag))
made_shot_prop
```

    ## # A tibble: 56 x 2
    ##    shot_distance made_shot_prop
    ##            <int>          <dbl>
    ##  1             0          0.841
    ##  2             1          0.668
    ##  3             2          0.534
    ##  4             3          0.373
    ##  5             4          0.411
    ##  6             5          0.286
    ##  7             6          0.396
    ##  8             7          0.395
    ##  9             8          0.463
    ## 10             9          0.321
    ## # ... with 46 more rows

6.2) ggplot

``` r
ggplot(data=made_shot_prop)+
  geom_point(aes(x=shot_distance, y=made_shot_prop))+
   ggtitle(' Percentage of Shot Made by Distance')
```

![](../images/shot%20distance%20plot-1.png)

\*what do you observe?

> The shorter the shooting distance, the higher the chabge to succefully make a shot.

\*Can you confirm that the shorter the distance, the more effective the shot

> Yes, overall we can confirm the fact. However, the percentage of shot made in the range of short distance (0~20 feet) are pretty similar.

\*Can you guesstimate a distance threshold beyond which the chance of making a successful shot is basically null?

> After 35 feet, the percentage of shot made is basically null.

\*What distances tend to have a percentage of 50% or more?

> Within 3 feet, the percentage of shot made is 50% or more.

7 Total number of shots by minute of occurrence
===============================================

``` r
shot_data %>%
  group_by(minute, name) %>%
  summarise(total = length(shot_type)) %>%
  ggplot(aes(x = minute, y = total)) +
  geom_rect(mapping = aes(xmin = 0, xmax = 12, ymin = 0, ymax = 60), fill = "light grey") +
  geom_rect(mapping = aes(xmin = 24, xmax = 36, ymin = 0, ymax = 60), fill = "light grey") +
  geom_point(color = "blue") +
  facet_wrap(~name) +
  geom_path(color = "blue") +
  ggtitle('Total number of shots(by minute of occurence)')+
  theme_minimal()
```

![](../images/shots%20by%20minutes-1.png)

\*Description of the facetted graph ot total number of shots:

> These graphs represent GSW players' total numberof shots by minute of occurence. Andre Iguoadala tends to succefully make shots during 2nd and the latter half of third period. Graymond Green makes shots during 1st and 2nd period. Kevin Durant steadily makes shots all periods. Klay Thompson and Stephen curry display pretty similar tendencies. The one interesting thing is when Klay has the lowest total number of shots made during 1st and 3rd period, curry has the highest total number of shots made at the same period. Probably it is because they have the same special ability,three-point field goals.
