\name{time_lapse}
\alias{time_lapse}
\title{Default plot for a single timeunit worth of data (one frame of animation).}
\usage{
time_lapse(node_data_table, time_unit = "week", download_basemap = TRUE,
  plot_single_timeunit_FUN = plot_single_timeunit, verbose = FALSE, ...)
}
\arguments{
  \item{node_data_table}{data.table containing, at least
  lat, lon, and time_stamp. lat + lon must be in WGS84.
  time_stamp must be of type R POSIXct.}

  \item{time_unit}{Time unit for each frame. As per
  lubridate::round_date, should be one of
  "second","minute","hour","day", "week", "month", or
  "year."}

  \item{plot_single_timeunit_FUN}{Function for plotting a
  single frame. See plot_single_timeunit for details on
  what the function should look like.}

  \item{verbose}{A flag to determine whether progress of
  the time lapse making process are printed out to the
  console.}

  \item{...}{Other parameters to be passed to
  plot_single_timeunit. Eg. highlight, alpha, size.}
}
\description{
Default plot for a single timeunit worth of data (one frame
of animation).
}

