#### Preamble ####
# Purpose: Cleans the raw municipal election data by...
# Author: Inessa De Angelis
# Date: 25 May 2023
# Contact: inessa.deangelis@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(janitor)

#### Read in raw data ####

# Read in the raw voter statistics data. 
readr::read_csv("inputs/data/raw_voter_statistics.csv")

# Read in the raw voting locations data. 
readr::read_csv("inputs/data/raw_voting_locations.csv")

#### Data Cleaning ####

# select columns of interest #
raw_voter_statistics |>
  select(
    ward,
    sub,
    total_eligible_electors,
    number_voted,
  )
