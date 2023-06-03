#### Preamble ####
# Purpose: Cleans the raw voter statistics by simplifying names and selecting the relevant columns from the data set
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
  ) |>
  mutate(
    ward = as.numeric(ward)
  ) |>
head(cleaned_voter_statistics)

# Convert percent voted from character vector to numeric
# Code referenced from: https://stackoverflow.com/questions/48273085/how-to-convert-a-character-vector-to-numeric
cleaned_voter_statistics |>
  select(percent_voted) |>
  mutate(
    percent_voted = as.numeric(factor(percent_voted))
)
  
# save cleaned voter statistics data #
# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
write_csv(
  x = cleaned_voter_statistics,
  file = "cleaned_voter_statistics.csv"
)

# count number of subdivisions per ward #
# based on code from: https://tellingstorieswithdata.com/20-r_essentials.html 

#Filter by ward and count number of subdivisions 
summarized_voter_statistics = 
  cleaned_voter_statistics |>
  select(ward, sub) |>
  group_by(ward) |>
  count(
    total = max(sub, na.rm = TRUE) 
  ) |>
  select(ward, n) |>
  filter(n > 26) 
summarized_voter_statistics |>
rename(
 subdivisions = n,
) 

# Summarize voter turnout by ward
summarized_voter_turnout = 
  cleaned_voter_statistics |>
  select(ward, percent_voted) |>
  group_by(ward) |>
  count(
    Turnout = mean(percent_voted) 
  )
summarized_voter_turnout


# save summarized voter statistics data #
# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
write_csv(
  x = summarized_voter_statistics,
  file = "summarized_voter_statistics.csv"
)

#### Data validation ####

# Check that there are no more than 25 wards #
# Referenced code from: https://github.com/christina-wei/INF3104-1-Covid-Clinics/blob/main/scripts/00-simulation.R
summarized_voter_statistics |>
  group_by(ward) |>
  count() |>
  filter(n > ward) |>
  sum() == 0

# Check that number of subdivisions per ward is between 38 and 94
summarized_voter_statistics$n |> min() == 38
summarized_voter_statistics$n |> max() == 94

# Check that voter turnout is between 11% and 100% #
cleaned_voter_statistics$percent_voted |> min() == 11
cleaned_voter_statistics$percent_voted|> max() == 100