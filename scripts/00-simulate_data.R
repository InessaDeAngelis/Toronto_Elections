#### Preamble ####
# Purpose: Simulate the 2022 Toronto Municipal Election voter statistics data set
# Author: Inessa De Angelis
# Date: 28 May 2023 
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Data sets:
## - https://open.toronto.ca/dataset/elections-voter-statistics/ 
# Note: Only download the 2022 election data from the webpage

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Data expectations ####
# There are a similar number of subdivisions per ward
# Voter turnout varies by ward
# Wards with more subdivisions will have a higher turnout

#### Simulate voter turnout by ward ####
#based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html#simulate

simulated_data <-
  tibble(
  #use 1 through 25 to represent each ward
  "ward" = 1:25,
  #randomly pick an option, with replacement, 25 times
  "turnout" = sample(
    x = c("25%", "22%", "30%", "34%", "38%"),
    size = 25,
    replace = TRUE
    )
  )

simulated_data

#### Simulate number of subdivisions by ward ####

set.seed(300)

simulate_data <-
  tibble(
   #use 1 through 25 to represent each ward
    "ward" = 1:25,
    #randomly pick an option, between 50 and 75, without replacement, 25 times
    "number_subdivision" = x <- sample(50:75, 25, replace=F),
    )

simulate_data

#### Simulate comparing the voter turnout to number of subdivisions per ward ####

set.seed(300)

simulate_data <-
  tibble(
    #use 1 through 25 to represent each ward
    "ward" = 1:25,
    #randomly pick an option, without replacement, 25 times
    "turnout" = x <- sample(19:44, 25, replace=F),
      #randomly pick an option, between 50 and 75, without replacement, 25 times
      "number_subdivision" = x <- sample(50:75, 25, replace=F),
    )

simulate_data

#### Graph voter turnout per ward ####
#Code referenced from: https://r-graph-gallery.com/218-basic-barplots-with-ggplot2.html

set.seed(300)

# Create data
data <- data.frame(
  ward=c("1","2","3","4","5") ,  
  turnout=c(25,22,30,34,38)
)

# Barplot
ggplot(data, aes(x=ward, y=turnout)) + 
  geom_bar(stat = "identity") 

#### Graph number of subdivisions per ward ####
#Code referenced from: https://r-graph-gallery.com/218-basic-barplots-with-ggplot2.html

set.seed(300)

# Create data
data <- data.frame(
  ward=c("1","2","3","4","5") ,  
  subdivisions=c(53,57,65,71,75)
)

# Barplot
ggplot(data, aes(x=ward, y=subdivisions)) + 
  geom_bar(stat = "identity") 

#### Graph subdivisions and voter turnout per ward ####
#Code referenced from: https://r-graph-gallery.com/218-basic-barplots-with-ggplot2.html

set.seed(300)

# Create data
data <- data.frame(
  turnout=c("25","22","30","34","38") ,  
  subdivisions=c(53,57,65,71,75)
)

# Barplot
ggplot(data, aes(x=turnout, y=subdivisions)) + 
  geom_bar(stat = "identity") 

#### Data Validation ####

# Check that there are between 1 and 25 wards #
# Referenced code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
simulate_data$ward |> min() == 1
simulate_data$ward |> max() == 25

# Check that there are no more than 25 wards #
# Referenced code from: https://github.com/christina-wei/INF3104-1-Covid-Clinics/blob/main/scripts/00-simulation.R
simulate_data |>
  group_by(ward) |>
  count() |>
  filter(n > ward) |>
  sum() == 0

# Check that voter turnout per ward is between 19% and 44% #
simulate_data$turnout |> min() == 19
simulate_data$turnout |> max() == 44

# Check that the number of subdivisions per ward is between 50 and 75 #
simulate_data |>
  group_by(number_subdivision) |>
  count() |>
  filter(n > number_subdivision) |>
  sum() == 0
