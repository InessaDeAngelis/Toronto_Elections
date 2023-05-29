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

#### Basic cleaning ####
# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
raw_voter_statistics <-
  read_csv(
    file = "inputs/data/raw_voter_statistics.csv",
    show_col_types = FALSE
  )

# Name organization#
cleaned_voter_statistics <-
  clean_names(raw_voter_statistics)

head(cleaned_voter_statistics)

# Rename % voted column #
cleaned_voter_statistics <-
  cleaned_voter_statistics |>
  rename(
    %_voted = percentage_voted,
  )

head(cleaned_voter_statistics)

# select columns of interest #
cleaned_voter_statistics <-
  cleaned_voter_statistics |>
  select(
    ward,
    sub,
    total_eligible_electors,
    number_voted,
  )
head(cleaned_voter_statistics)
