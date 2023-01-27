library(tidyverse)
library(sf)
library(lubridate)

theme_set(theme_bw() + theme(panel.background = element_rect(fill = "lightblue")))

source(here::here("data.R"))

bbox <- st_bbox(dma)
lon_bounds <- c(bbox$xmin, bbox$xmax)
lat_bounds <- c(bbox$ymin, bbox$ymax)

ggplot() +
  geom_sf(data = ssz, fill = "steelblue") +
  geom_sf(data = states) +
  geom_sf(data = dma, fill = NA) +
  coord_sf(xlim = lon_bounds, ylim = lat_bounds)


# plot by month
ggplot() +
  geom_sf(data = ssz, fill = "steelblue") +
  geom_sf(data = states) +
  geom_sf(data = dma %>% filter(year(date) == 2020 & month(date) == 1),
          fill = NA) +
  coord_sf(xlim = lon_bounds, ylim = lat_bounds) + 
  annotate("text",
           x = -70,
           y = 35, 
           label = paste(month.name[1], ", ", 2020, sep = ""))


plot_by_month <- function(month, year) {
  ggplot() +
    geom_sf(data = ssz, fill = "steelblue") +
    geom_sf(data = states) +
    geom_sf(data = dma %>% filter(year(date) == year & month(date) == month),
            fill = NA) +
    coord_sf(xlim = lon_bounds, ylim = lat_bounds) + 
    annotate("text",
             x = -70,
             y = 35, 
             label = paste(month.name[month], ", ", year, sep = ""))
}

plot_by_month(2, 2022)
