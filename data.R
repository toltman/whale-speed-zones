ssz <- read_sf(here::here(
  "data", 
  "Proposed_Right_Whale_Seasonal_Speed_Zones", 
  "Proposed_Right_Whale_Seasonal_Speed_Zones.shp"
))

states <- read_sf(here::here(
  "data",
  "cb_2018_us_state_20m",
  "cb_2018_us_state_20m.shp"
))

east_coast = c(
  "Connecticut",
  "Delaware",
  "Florida",
  "Georgia",
  "Maine",
  "Maryland",
  "Massachusetts",
  "New Hampshire",
  "New York",
  "New Jersey",
  "North Carolina",
  "Pennsylvania",
  "Rhode Island",
  "South Carolina",
  "Vermont",
  "Virginia",
  "West Virginia",
  "District of Columbia"
)

states <- states %>% filter(NAME %in% east_coast)

dma <- readxl::read_excel(here::here(
  "data",
  "DMA coordinates",
  "2021 DMA-Slow Zones.xlsx"
))

dma <- dma %>%
  separate(
    Boundaries, 
    c("lat_degree_A", "lat_min_A",
      "lat_degree_B", "lat_min_B",
      "lon_degree_A", "lon_min_A",
      "lon_degree_B", "lon_min_B"
    ),
    sep = "\\D+",
    remove = FALSE,
    convert = TRUE
  ) %>% 
  mutate(
    latA = lat_degree_A + lat_min_A / 60, 
    latB = lat_degree_B + lat_min_B / 60,
    lonA = lon_degree_B + lat_min_B / 60,
    lonB = lon_degree_B + lon_min_B / 60
  )


dma <- st_as_sf(dma %>% filter(!is.na(latA)), coords = c("latA", "lonA", "latB", "lonB"))
