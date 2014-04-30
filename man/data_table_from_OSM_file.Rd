\name{data_table_from_OSM_file}
\alias{data_table_from_OSM_file}
\title{Create a data.table with lat,lon,timestamp given an osm file.
OSM file can be a .csv file, a .osm file or a .pbf file.
If .osm or .pbf file are input, then osm_convert must be the path to
the osm_convert command. A .csv file with an identical basename will be created.}
\usage{
data_table_from_OSM_file(osm_file, osm_convert = "osm_convert")
}
\arguments{
  \item{osm_file}{The osm_file to process. Can be a .csv,
  .osm, or .pbf file.}

  \item{osm_convert}{Path to the osm_convert command-line
  utility. See
  http://wiki.openstreetmap.org/wiki/Osmconvert for
  installation.}
}
\value{
A data.table, with lat, lon, and timestamp columns.
}
\description{
Create a data.table with lat,lon,timestamp given an osm
file. OSM file can be a .csv file, a .osm file or a .pbf
file. If .osm or .pbf file are input, then osm_convert must
be the path to the osm_convert command. A .csv file with an
identical basename will be created.
}

