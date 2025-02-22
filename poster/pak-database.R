library(cranlogs)
library(pkgsearch)
library(dplyr)
library(ggplot2)
options(scipen = 99)

# table with packages
# - Documentation
# - Active development
# - No. of downloads
# - Performance?
#   - Citations from spatial journals
# - Divided by features: tune, selection, cv
# - Do geometries need to be dropped before the next steps

sml_pak = tibble::tribble(
  ~package, ~type, ~framework, ~spatial,
  #"sf", "general", "none", TRUE,
  #"terra", "general", "none", TRUE, 
  #"stars", "general", "none", TRUE,
  "tidymodels", "ml", "tidymodels", FALSE,
  #"ranger", "ml", "none", FALSE,
  "spatialsample", "validation", "tidymodels", TRUE,
  # "mlr3verse", "ml", "mlr3", FALSE,
  "mlr3", "ml", "mlr3", FALSE,
  # "mlr3spatial", "ml", "mlr3", TRUE,
  "mlr3spatiotempcv", "validation", "mlr3", TRUE,
  "caret", "ml", "caret", FALSE,
  "CAST", "ml", "caret", TRUE,
  "blockCV", "validation", "none", TRUE,
  "RandomForestsGLS", "ml", "none", TRUE,
  "spatialRF", "ml", "none", TRUE,
  #"SpatialML", "ml", "none", TRUE,
  "sperrorest", "validation", "none", TRUE,
  "meteo", "ml", "none", TRUE,
  "waywiser", "ml", "tidymodels", TRUE
)

# read packages downloads -------------------------------------------------
dd_top = cran_downloads(packages = sml_pak$package, from = "2024-01-01", to = "2024-12-31") |> 
  group_by(package) |> 
  summarize(Downloads = sum(count))
dd_top

# read packages metadata
pak_meta = pkgsearch::cran_packages(sml_pak$package) |>
  select(Package, Version, date, License) |>
  mutate(date = as.Date(date))

# merge info
sml_pak_df = sml_pak |> 
  left_join(dd_top, by = c("package" = "package")) |> 
  left_join(pak_meta, by = c("package" = "Package")) |>
  select(Name = package, Framework = framework, License, Version, `Last update` = date, `Downloads (2024)` = Downloads) |>
  mutate(License = stringr::str_replace_all(License, " \\+ file LICENSE| \\| file LICENCE", "")) |>
  mutate(Framework = factor(Framework, levels = c("caret", "tidymodels", "mlr3", "none"))) |>
  mutate(Name = factor(Name, levels = c("caret", "CAST", "tidymodels", "spatialsample", "waywiser", "mlr3", "mlr3spatiotempcv",
                                        "RandomForestsGLS", "spatialRF", "meteo", "sperrorest", "blockCV"))) |>
  arrange(Name)

# Data preprocessing and feature engineering
prep_df = tibble::tribble(
  ~package, ~category, ~description,
  "sf", "Data preprocessing and feature engineering", "A standardized way to work with spatial vector data using R",
  "terra", "Data preprocessing and feature engineering", "A large set of tools to work with spatial raster and vector data using R",
  "stars", "Data preprocessing and feature engineering", "A package to work with spatial data cubes using R",
)

# Spatial model creation
smlc_df = tibble::tribble(
  ~package, ~category, ~description,
  "RandomForestsGLS", "Spatial model creation", "Random Forest extension with spatial dependency handling",
  #"SpatialML", "Spatial model creation", "A package to create spatial models using machine learning",
  "spatialRF", "Spatial model creation", "Random Forest modeling with additional spatial predictors",
  "meteo", "Spatial model creation", "Spatial interpolation using Random Forest through nearest observations and distances to the target location"
)

# Spatial hyperparameter tuning and validation
shtv_df = tibble::tribble(
  ~package, ~category, ~description,
  "CAST", "Spatial hyperparameter tuning and validation", "Various spatial cross-validation methods with feature selection support",
  "spatialsample", "Spatial hyperparameter tuning and validation", "Spatial resampling and validation with tidymodels interface",
  "mlr3spatiotempcv", "Spatial hyperparameter tuning and validation", "Spatial and spatiotemporal cross-validation for mlr3",
  "sperrorest", "Spatial hyperparameter tuning and validation", "Customizable spatial cross-validation with error estimation",
  "blockCV", "Spatial hyperparameter tuning and validation", "Block, spatial, and environmental cross-validation partitionings with visualizations options"
)

# Model interpretation and visualization
miv_df = tibble::tribble(
  ~package, ~category, ~description,
  "CAST", "Model interpretation and visualization", "Evaluation of spatial predictive conditions, area of applicability",
  "waywiser", "Model interpretation and visualization", "Approaches for measuring the spatial structure of model errors, assessing model predictions at multiple spatial scales, and evaluating area of applicability"
)
