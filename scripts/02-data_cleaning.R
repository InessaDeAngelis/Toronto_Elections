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

# save summarized voter statistics data #
# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
write_csv(
  x = summarized_voter_statistics,
  file = "summarized_voter_statistics.csv"
)

# Add voter turnout by ward from cleaned_voter_statistics data set
summarized_voter_turnout <-
  data <- data.frame(
    ward=c("1","2","3","4","5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25") ,  
    turnout=c(24, 30, 33, 38, 28, 25, 22, 32, 31, 24, 32, 34, 29, 36, 33, 31, 27, 29, 36, 32, 26, 26, 25, 27, 27)
  )
summarized_voter_turnout
  
# save summarized voter turnout data #
# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
write_csv(
  x = summarized_voter_turnout,
  file = "summarized_voter_turnout.csv"
)

# Merge number of subdivisions and voter turnout
finalized_voter_statistics = 
  merge(
    summarized_voter_turnout,
    summarized_voter_statistics,
    by = "ward"
  )
finalized_voter_statistics

# save finalized voter statistics data #
# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
write_csv(
  x = finalized_voter_statistics,
  file = "finalized_voter_statistics.csv"
)

#### Data validation ####

# Check that there are no more than 25 wards #
# Referenced code from: https://github.com/christina-wei/INF3104-1-Covid-Clinics/blob/main/scripts/00-simulation.R
finalized_voter_statistics |>
  group_by(ward) |>
  count() |>
  filter(n > ward) |>
  sum() == 0

# Check that number of subdivisions per ward is between 38 and 94
finalized_voter_statistics$n |> min() == 38
finalized_voter_statistics$n |> max() == 94

# Check that voter turnout is between 22% and 38% #
finalized_voter_statistics$turnout |> min() == 22
finalized_voter_statistics$turnout|> max() == 38