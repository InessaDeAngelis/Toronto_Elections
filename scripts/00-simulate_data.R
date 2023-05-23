#### Preamble ####
# Purpose: Simulate the 2022 Toronto Municipal Election ward locations and results data sets 
# Author: Inessa De Angelis
# Date: 25 May 2023 
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Data sets: https://open.toronto.ca/dataset/elections-voting-locations/ & https://open.toronto.ca/dataset/election-results-official/ & https://open.toronto.ca/dataset/elections-voter-statistics/
# Note: For each webpage, only download the 2022 election data 

#### Workspace setup ####
library(tidyverse)

#### Data expectations ####
# There are a similar or identical number of polling locations per ward
# The polling locations in each ward in equally spaced out within the ward boundaries
# columns: ward, building_name, building_address, %_voted

#### Simulate data ####

## Assumptions

# Fictional ward, voting locations, and voter turnout
sim_ward = c("Ward1", "Ward2", "Ward3", "Ward44")
sim_locations = c(55, 52, 57, 56)
sim_turnout = c("22%", "27%", "32%", "38%")

## Create summary statistics of number of polling locations per ward and 
## compare it with the voter turnout by ward

# summarize polling locations by ward
polling_locations_per_ward = 
  simulated_data |>
  group_by(ward) |>
  count() |>
  rename("num_locations" = "n")

# add voter turnout column to the data
locations_per_ward['turnout'] = sim_turnout

# compute bps per ward
locations_per_ward =
  locations_per_ward |>
  mutate(
    bps_of_ward =
      num_locations / population * 10000
  )
