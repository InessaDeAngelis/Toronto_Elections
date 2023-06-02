#### Preamble ####
# Purpose: Cleans the raw voter statistics and voting locations data by simplifying names and selecting the relevant columns from each data set
# Author: Inessa De Angelis
# Date: 25 May 2023
# Contact: inessa.deangelis@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(dplyr)

#### Read in raw data ####

# Read in the raw voter statistics data. 
readr::read_csv("inputs/data/raw_voter_statistics.csv")

# Read in the raw voting locations data. 
readr::read_csv("inputs/data/raw_voting_locations.csv")

#### Basic cleaning - voter statistics ####
# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
raw_voter_statistics <-
  read_csv(
    file = "inputs/data/raw_voter_statistics.csv",
    show_col_types = FALSE
  )

# Name organization #
cleaned_voter_statistics <-
  clean_names(raw_voter_statistics)

head(cleaned_voter_statistics)

# select columns of interest #
cleaned_voter_statistics <-
  cleaned_voter_statistics |>
  select(
    ward,
    sub,
    total_eligible_electors,
    number_voted,
    percent_voted
  )
head(cleaned_voter_statistics)

# save cleaned voter statistics data #
# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
write_csv(
  x = cleaned_voter_statistics,
  file = "cleaned_voter_statistics.csv"
)

#### Basic cleaning - voting locations ####

#### Basic cleaning ####
# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
raw_voting_locations<-
  read_csv(
    file = "inputs/data/raw_voting_locations.csv",
    show_col_types = FALSE
  )

# Name organization #
cleaned_voting_locations <-
  clean_names(raw_voting_locations)

head(cleaned_voting_locations)

# select columns of interest #
cleaned_voting_locations <-
  cleaned_voting_locations |>
  select(
    point_short_code,
    point_long_code,
    address_full,
    geometry
  )
head(cleaned_voting_locations)

# save cleaned voting locations data #
# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
write_csv(
  x = cleaned_voting_locations,
  file = "cleaned_voting_locations.csv"
)

# count number of subdivisions per ward #
# based on code from: https://tellingstorieswithdata.com/20-r_essentials.html 

#Filter by ward and count number of subdivisions 
summarized_voter_statistics = 
  cleaned_voter_statistics |>
  group_by(ward) |>
  count(
    total = max(sub, na.rm = TRUE) 
  ) |>
  arrange(desc(ward)) |>
  arrange(desc(n)) |>
  select(ward, n)
summarized_voter_statistics


# save summarized voter statistics data #
# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
write_csv(
  x = summarized_voter_statistics,
  file = "summarized_voter_statistics.csv"
)
