\name{single_timeunit_plot}
\alias{single_timeunit_plot}
\title{Default plot for a single timeunit worth of data (one frame of animation).}
\usage{
single_timeunit_plot(before, this, total_by_timeunit, timeunit_pretty,
  basemap = NULL)
}
\arguments{
  \item{before}{data.table for all the (uninclusive)
  previous timeunit data.}

  \item{this}{data.table for this timeunit's data.}

  \item{total_by_timeunit}{data.table with a summary of
  total observations per timeunit.}

  \item{timeunit_pretty}{A pretty printed version of the
  timeunit (eg. Week for week).}

  \item{basemap}{A basemap to plot data on top of. Must be
  a ggplot object.}
}
\description{
Default plot for a single timeunit worth of data (one frame
of animation).
}

