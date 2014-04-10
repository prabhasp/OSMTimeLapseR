## Transform data pre-time-lapse.
## What we do:
## 1. Convert timestamp to time object
## 2. Calculate week
## 3. Calculate unixDay

require(lubridate); require(stringr)
lsub <- readRDS("TimeLapse/node_attrs.RDS")
lsub <- subset(lsub, select=c("lat", "lon", "timestamp"))

# lubridate doesn't handle ISO 8601 datetimes yet, so we just chuck the timezone info
iso8601DateTimeConvert <- function(x) { ymd_hms(str_extract(x, '^[^+Z]*(T| )[^+Z-]*')) }

lsub$timestamp <- iso8601DateTimeConvert(lsub$timestamp)
lsub$week <- round_date(lsub$timestamp, unit="week")

saveRDS(lsub, "TimeLapse/node_data.RDS")
