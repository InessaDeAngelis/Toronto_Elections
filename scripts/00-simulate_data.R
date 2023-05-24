#### Preamble ####
# Purpose: Simulate the 2022 Toronto Municipal Election ward locations and results data sets 
# Author: Inessa De Angelis
# Date: 25 May 2023 
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites: none
# Data sets: https://open.toronto.ca/dataset/elections-voting-locations/ & https://open.toronto.ca/dataset/elections-voter-statistics/
# Note: For each webpage, only download the 2022 election data 

#### Workspace setup ####
library(tidyverse)

#### Data expectations ####
# There are a similar or identical number of polling locations per ward
# The polling locations in each ward in equally spaced out within the ward boundaries
# columns: _id, point_name, point_short_code, voter_count

#### Simulate data ####

## Assumptions

# Fictional point name, point short code, and voter count
sim_id = c("1", "2", "3", "4")
sim_point_name = c("Catholic_Church", "High_School", "Apartments", "Nursing_Home")
sim_point_short_code = c(042, 025, 033, 060)
sim_voter_count = c("1000", "1700", "500", "2100")

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
