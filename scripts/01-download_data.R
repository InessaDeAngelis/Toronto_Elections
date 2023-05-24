#### Preamble ####
# Purpose: Downloads and saves the data from OpenDataToronto portal
# Author: Inessa De Angelis
# Date: 25 May 2023
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)
library(readr)
source("scripts/04-helper_functions.R")

#### Download data and write municipal election polling location data ####

# download data
raw_voting_locations = download_data_from_opendatatoronto (
package_id = "31dac8b2-2e15-4945-abef-ce98d248bb8e",
resource_id = "31dac8b2-2e15-4945-abef-ce98d248bb8e"
)

# write data
write.csv (
  x = raw_voting_locations,
  file = "inputs/data/raw_voting_locations.csv"
)