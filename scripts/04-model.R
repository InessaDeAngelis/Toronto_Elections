#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Inessa De Angelis
# Date: 22 May 2023
# Contact: inessa.deangelis@mail.utoronto.ca
# License: MIT
# Pre-requisites: none

#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_csv("outputs/data/analysis_data.csv")

### Model data ####
first_model <-
  stan_glm(
    formula = flying_time ~ length + width,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  first_model,
  file = "outputs/models/first_model.rds"
)


