OSM-TimeLapseR
==============
For a demo, see http://prabhasp.github.io/OSM-TimeLapseR/TimeLapse/all.html

Dependencies
---
 * Install R ([http://prabhasp.github.io/OSM-TimeLapseR/TimeLapse/all.html](Mac), [Windows](http://cran.r-project.org/bin/windows/base/), [Other](http://cran.r-project.org/bin/))
 * Install the R package dependencies
   * Open R
   * `install.packages("ggplot2", "data.table", "stringr", "lubridate", "animation", "gridExtra")`
 * Install [http://wiki.openstreetmap.org/wiki/Osmconvert](osmconvert)

Running a file through the visualizer
---
  1. Generate a csv file with lat/lon/timestamp files with osmconvert. Example command:
  ```
  osmconvert ~/Downloads/kathmandu.osm --csv="@lat @lon @timestamp" --csv-separator="," -o=kathmandu_nodes.csv
  ```
  Replace kathmandu.osm with the appropriate source osm file that osmconvert accepts, and kathmandu_nodes.csv with your own csv file name.

  2. ??
  3. Profit!
