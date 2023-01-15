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