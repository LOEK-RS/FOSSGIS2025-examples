# Comparison of spatial machine learning packages in R

### Case study data

```{r data}
#| message: false
#| warning: false

spain = sf::read_sf("data/spain.gpkg")
covariates = terra::rast("data/predictors.tif")
temperature = sf::read_sf("data/temp_train.gpkg")

temperature = terra::extract(covariates, temperature, bind = TRUE) |> 
  sf::st_as_sf()
```

Terminology specific to the example data:

- `spain` is the region outline - for visualization purposes 
- `covariates` are the spatially explicit data data to predict on (to prevent wording confusions with the predict function)
- `temperature` are the measured temperature data (i.e. the response variable, i.e. the ground truth) along with the covariates at the measurement location

## Outline

- Design paradigms
- Quality of documentation

## Thoughts

In `caret`, if we want to use spatial data, we have to specifically exclude the 
geometry column of the `sf` object. We lose the spatial information in the process 
of model training and prediction. However, this information can be critical,
e.g. if we want to use `CAST::errorprofiles()` or `CAST::knncv()`. Is this also the case for **mlr3** and **tidymodels**?

Please use the **ranger** implementation of Random Forest!

