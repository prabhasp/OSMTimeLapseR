\name{time_lapse}
\alias{time_lapse}
\title{Default plot for a single timeunit worth of data (one frame of animation).}
\usage{
time_lapse(node_data_table, time_unit = "week",
  single_timeunit_plot_FUN = single_timeunit_plot, verbose = FALSE,
  downloadBaseMap = TRUE)
}
\arguments{
  \item{node_data_table}{data.table containing, at least
  lat, lon, and time_stamp. lat + lon must be in WGS84.
  time_stamp must be of type R POSIXct.}

  \item{time_unit}{Time unit for each frame. As per
  lubridate::round_date, should be one of
  "second","minute","hour","day", "week", "month", or
  "year."}

  \item{single_timeunit_plot_FUN}{Function for plotting a
  single frame. See single_timeunit_plot for details on
  what the function should look like.}

  \item{verbose}{A flag to determine whether progress of
  the time lapse making process are printed out to the
  console.}
}
\description{
Default plot for a single timeunit worth of data (one frame
of animation).
}

