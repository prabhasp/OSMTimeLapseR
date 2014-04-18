## Transform data pre-time-lapse.
## What we do:
## 1. Convert timestamp to time object
## 2. Calculate week
## 3. Calculate unixDay

require(lubridate); require(stringr); require(data.table)
lsub <- data.table(setNames(read.csv("kathmandu_nodes.csv", header=F), c("lat", "lon", "timestamp")))

# lubridate doesn't handle ISO 8601 datetimes yet, so we just chuck the timezone info
iso8601DateTimeConvert <- function(x) { ymd_hms(str_extract(x, '^[^+Z]*(T| )[^+Z-]*')) }

lsub$timestamp <- iso8601DateTimeConvert(lsub$timestamp)

saveRDS(lsub, "TimeLapse/node_data.RDS")
