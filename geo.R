library(tidyverse)
library(sf)

theme_set(theme_bw())

source(here::here("data.R"))

bbox <- st_bbox(ssz)
lon_bounds <- c(bbox$xmin, bbox$xmax)
lat_bounds <- c(bbox$ymin, bbox$ymax)

ggplot() +
  geom_sf(data = ssz, aes(fill = ssz)) +
  geom_sf(data = states) +
  geom_sf(data = dma %>% select("General Location") %>% filter(`General Location` == "South of Nantucket Island"), fill = "steelblue", alpha = 0.5) +
  coord_sf(xlim = lon_bounds, ylim = lat_bounds)


plot_regional_zone <- function(df, name) {
  
  df <- df %>% filter(ssz == name)
  
  bbox <- st_bbox(df)
  lon_bounds <- c(bbox$xmin, bbox$xmax)
  lat_bounds <- c(bbox$ymin, bbox$ymax)
  
  ggplot() +
    geom_sf(data = ssz) +
    geom_sf(data = states) +
    coord_sf(xlim = lon_bounds, ylim = lat_bounds)
  
}

plot_regional_zone(ssz, "Southeast")
plot_regional_zone(ssz, "South Carolina")
plot_regional_zone(ssz, "North Carolina")
plot_regional_zone(ssz, "Great South Channel")
plot_regional_zone(ssz, "Atlantic")
