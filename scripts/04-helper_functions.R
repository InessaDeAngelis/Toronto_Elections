#### Preamble ####
# Author: Inessa De Angelis
# Date: 25 May 2023
# Contact: inessa.deangelis@mail.utoronto.ca 
# License: MIT
# Pre-requisites: none

#### Workspace setup ####

library(opendatatoronto)

## Download data from opendatatoronto
download_data_from_opendatatoronto = function(package_id) {
  
  raw_data = 
    list_package_resources(package_id) |> # get resources for the package_id
    get_resource() #download data
}
