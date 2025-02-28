# poster figures

library(sf)
library(terra)
library(tidyverse)
library(blockCV)
library(tmap)
library(caret)
library(CAST)

spain = tmapspain = read_sf("data/spain.gpkg")
response = read_sf("data/temp_train.gpkg")
covariates = rast("data/predictors.tif")


traindata = terra::extract(covariates, response, bind = TRUE) |> st_as_sf()
traindata = traindata |> st_drop_geometry()


model = train(temp ~ ., data = traindata,
              method = "ranger", num.trees = 100)



AOA = aoa(model = model, newdata =  covariates)

AOAmod = AOA$DI > 0.4

png(filename = "poster/images/aoa.png", bg = "transparent")
plot(AOAmod, legend = FALSE, axes = FALSE, col = c("lightgoldenrod1", "grey30"))
dev.off()



prediction = terra::predict(covariates, model, na.rm = TRUE)


png(filename = "poster/images/prediction.png", bg = "transparent")
plot(prediction, legend = FALSE, axes = FALSE)
dev.off()


ggplot(spain)+
  geom_sf()+
  geom_sf(data = response)+
  theme(panel.background = element_blank(),
        axis.line =  element_blank(),
        axis.ticks = element_blank())

ggsave("poster/images/spain_plots.png", bg = "transparent")


png(filename = "poster/images/spain_cov1.png", bg = "transparent")
plot(covariates[["dem"]], legend = FALSE, axes = FALSE)
dev.off()
png(filename = "poster/images/spain_cov2.png", bg = "transparent")
plot(covariates[["X"]], legend = FALSE, axes = FALSE)
dev.off()

png(filename = "poster/images/spain_cov3.png", bg = "transparent")
plot(covariates[["Y"]], legend = FALSE, axes = FALSE)
dev.off()

blockCV::cv_spatial(response, r = covariates, raster_colors = "grey80")
ggsave("poster/images/blockCV.png")













