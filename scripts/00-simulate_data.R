#### Preamble ####
# Purpose: Simulate the 2022 Toronto Municipal Election ward locations and results data sets 
# Author: Inessa De Angelis
# Date: 25 May 2023 
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Data sets:
## - https://open.toronto.ca/dataset/elections-voting-locations/ 
## - https://open.toronto.ca/dataset/elections-voter-statistics/ 
# Note: Only download the 2022 election data from the webpages

#### Workspace setup ####
# install.packages("tidyverse")
library(tidyverse)

#### Data expectations ####
# There are a similar or identical number of subdivisions per ward
# columns: ward, sub

#### Simulate data ####

simulated_data <-
  tibble(
  #use 1 through 25 to represent each ward
  )

