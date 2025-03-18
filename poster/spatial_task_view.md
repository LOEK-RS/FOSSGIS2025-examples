---
name: Spatial
topic: Analysis of Spatial Data
maintainer: Roger Bivand, Jakub Nowosad
email: Roger.Bivand@nhh.no, nowosad.jakub@gmail.com
version: 2024-12-24
source: https://github.com/cran-task-views/Spatial/
---

### Machine learning of spatial data

Machine learning of spatial data uses specialized approaches and methods to account for spatial dependencies and relationships when building models.
In general, machine learning of spatial data can be performed through one of the existing machine learning frameworks in R, such as `r pkg("caret")`, `r pkg("mlr3")`, and `r pkg("tidymodels")` or through specialized spatial machine learning packages.

- The `r pkg("caret")` package provides a consistent interface for training models but requires additional packages like `r pkg("blockCV")` or `r pkg("CAST")` to implement spatial methodologies. Functions like `CAST::knndm` and `CAST::ffs` enable spatially aware feature selection and cross-validation, while `CAST::aoa` assesses the area of applicability for spatial models.
-   `r pkg("mlr3")` with `r pkg("mlr3spatial")` and `r pkg("mlr3spatiotempcv")` takes an object-oriented approach with R6 classes for direct spatial object handling and cross-validation within its structured syntax.
-   `r pkg("tidymodels")` with `r pkg("spatialsample")` and `r pkg("waywiser")` introduces spatial sampling strategies and model evaluation tools following tidyverse principles, including `spatialsample::spatial_resample` and `waywiser::ww_area_of_applicability`.
-   `r pkg("RandomForestsGLS")` and `r pkg("spatialRF")` extend Random Forests to incorporate spatial relationships, offering specialized functions for spatial estimation, feature selection, and model assessment.
-   `r pkg("meteo")` implements Random Forest Spatial Interpolation by incorporating nearest observations and distances into the prediction process, making it well-suited for interpolation tasks.
-   `r pkg("sperrorest")` and `r pkg("blockCV")` provide frameworks for spatial resampling and validation, supporting methods like k-means clustering and block-based approaches to account for spatial dependencies in model evaluation.