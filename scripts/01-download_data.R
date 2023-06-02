#### Preamble ####
# Purpose: Downloads, saves, and reads data from the OpenDataToronto portal
# Author: Inessa De Angelis
# Date: 28 May 2023
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites: none

#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)
library(readr)

#### Download voter statistics data ####
# Code referenced from: https://cran.r-project.org/web/packages/opendatatoronto/opendatatoronto.pdf
# & https://github.com/sharlagelfand/opendatatoronto/blob/main/vignettes/articles/multiple_resources_purrr.Rmd

list_package_resources("7dc606ab-f042-4d90-99e2-9247cb5953d2") |>
  filter(grepl("2022", name)) |>
  head(1) |>
  get_resource()

# save raw voter statistics data #
# based on code from: https://tellingstorieswithdata.com/02-drinking_from_a_fire_hose.html
write_csv(
  x = raw_voter_statistics,
  file = "raw_voter_statistics.csv"
)

#### Read municipal election data ####

# Read in the raw voter statistics data. 
readr::read_csv("inputs/data/raw_voter_statistics.csv")