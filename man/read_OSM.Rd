\name{read_OSM}
\alias{read_OSM}
\title{Create a data.table with lat,lon,time_stamp given an osm file.
OSM file can be a .csv file, a .osm file or a .pbf file.
If .osm or .pbf file are input, then osmconvert must be the path to
the osmconvert command. A .csv file with an identical basename will be created.}
\usage{
read_OSM(osm_file, osmconvert = "osmconvert")
}
\arguments{
  \item{osm_file}{The osm_file to process. Can be a .csv,
  .osm, or .pbf file.}

  \item{osmconvert}{Path to the osmconvert command-line
  utility. See
  http://wiki.openstreetmap.org/wiki/Osmconvert for
  installation.}
}
\value{
A data.table, with lat, lon, and time_stamp columns.
}
\description{
Create a data.table with lat,lon,time_stamp given an osm
file. OSM file can be a .csv file, a .osm file or a .pbf
file. If .osm or .pbf file are input, then osmconvert must
be the path to the osmconvert command. A .csv file with an
identical basename will be created.
}

