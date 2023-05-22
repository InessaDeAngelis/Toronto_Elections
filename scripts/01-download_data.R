#### Preamble ####
# Purpose: Downloads and saves the data from OpenDataToronto portal
# Author: Inessa De Angelis
# Date: 22 May 2023
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)

#### Download data and write municipal election polling location data ####

# download data
raw_location_data = download_data_from_opendatatoronto
package_id = "31dac8b2-2e15-4945-abef-ce98d248bb8e"
resource_id = "31dac8b2-2e15-4945-abef-ce98d248bb8e"

#### Save data ####
# [...UPDATE THIS...]
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(the_raw_data, "inputs/data/raw_data.csv") 

         
