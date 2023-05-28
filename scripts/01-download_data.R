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

#### Download data and write municipal election data ####
# Code referenced from: https://cran.r-project.org/web/packages/opendatatoronto/opendatatoronto.pdf 

list_package_resources("https://open.toronto.ca/dataset/elections-voting-locations/") %>%
  head(1) %>%
  get_resource()

#### Read municipal election data ####

# Read in the raw voter statistics data. 
readr::read_csv("inputs/data/raw_voter_statistics.csv")

# Read in the raw voting locations data. 
readr::read_csv("inputs/data/raw_voting_locations.csv")
