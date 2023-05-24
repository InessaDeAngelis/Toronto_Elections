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

#### Download data and write voter statistics data ####

# download data
raw_voter_statistics = download_data_from_opendatatoronto (
  package_id = "7dc606ab-f042-4d90-99e2-9247cb5953d2"
)

# write data
write.csv (
  x = "raw_voter_statistics",
  file = "inputs/data/raw_voter_statistics.csv"
)
