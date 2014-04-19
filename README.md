OSM-TimeLapseR
==============
For a weekly visualization in HTML, see http://prabhasp.github.io/OSM-TimeLapseR/TimeLapse/all.html

For a yearly visualization in GIF, see http://prabhasp.github.io/OSM-TimeLapseR/TimeLapse/kathmandu_yearly.gif

Dependencies
---
 * Install R ([http://prabhasp.github.io/OSM-TimeLapseR/TimeLapse/all.html](Mac), [Windows](http://cran.r-project.org/bin/windows/base/), [Other](http://cran.r-project.org/bin/))
 * Install the R package dependencies
   * Open R
   * (This will get easier soon):
   * `install.packages("ggplot2", "data.table", "stringr", "lubridate", "animation", "gridExtra", "OpenStreetMap")`
   
 * Install [http://wiki.openstreetmap.org/wiki/Osmconvert](osmconvert)
 * If you want to make GIFs, [ImageMagick](http://www.imagemagick.org/)

Running a file through the visualizer
---
(This will get easier soon):
  1. Generate a csv file with lat/lon/timestamp files with osmconvert. Example command:
  ```
  osmconvert ~/Downloads/kathmandu.osm --csv="@lat @lon @timestamp" --csv-separator="," -o=kathmandu_nodes.csv
  ```
  Replace kathmandu.osm with the appropriate source osm file that osmconvert accepts, and kathmandu_nodes.csv with your own csv file name.

  2. Edit TimeLapse/TimeLapsePreProcess.R and TimeLapse/AnimateAll.R to refer to the correct filenames.
  3. `source("AnimateALL.R")` in the R console.
