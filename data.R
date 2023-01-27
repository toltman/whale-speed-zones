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

dma_2020 <- readxl::read_excel(here::here(
  "data",
  "DMA coordinates",
  "2020 DMA-Slow Zones.xlsx"
))

dma_2021 <- readxl::read_excel(here::here(
  "data",
  "DMA coordinates",
  "2021 DMA-Slow Zones.xlsx"
)) %>% 
  mutate(type = "None", .before = 2)

dma_2022 <- readxl::read_excel(here::here(
  "data",
  "DMA coordinates",
  "2022 DMA-Slow Zones.xlsx"
))

col_names <- c("date", "type", "number", "source", "location", "boundaries")
colnames(dma_2020) <- col_names
colnames(dma_2021) <- col_names
colnames(dma_2022) <- col_names

dma <- rbind(dma_2020, dma_2021, dma_2022)

dma <- dma %>%
  separate(
    boundaries, 
    c("lat_degree_A", "lat_min_A",
      "lat_degree_B", "lat_min_B",
      "lon_degree_A", "lon_min_A",
      "lon_degree_B", "lon_min_B"
    ),
    sep = "\\D+",
    remove = FALSE,
    convert = TRUE,
    extra = "drop"
  ) %>% 
  mutate(
    latA = lat_degree_A + lat_min_A / 60, 
    latB = lat_degree_B + lat_min_B / 60,
    lonA = lon_degree_A + lon_min_A / 60,
    lonB = lon_degree_B + lon_min_B / 60
  )

create_poly <- function(a, b, c, d) {
  rbind(c(a, c), c(a, d), c(b, d), c(b, c), c(a, c)) %>%
    list %>%
    st_polygon %>%
    st_as_text
}

dma <- dma %>% 
  filter(!is.na(latA)) %>%
  mutate(
    geometry = mapply(
      create_poly,
      -lonA,
      -lonB,
      latA,
      latB
    )
  )


dma$geometry <- st_as_sfc(dma$geometry, crs = 4326)
dma <- st_sf(dma)
