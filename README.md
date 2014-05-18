<link href="http://kevinburke.bitbucket.org/markdowncss/markdown.css" rel="stylesheet"></link>
OSMTimeLapseR
==============
Welcome to OSMTimeLapseR. This package helps you visualize the edits to OSM in a certain part of the world. It was developed based on a request from the OSM Nepal community, whose work growing OSM in Kathmandu can be seen below: 

![](demo/kathmandu_yearly.gif)

A monthly visualization is [here](demo/kathmandu_monthly.html).

**Note**: We are NOT visualizing all changes to OSM. We are only visualizing the last changed date of all nodes that still exist in OSM. This under-reports changes, and is slightly biased towards later dates. In Kathmandu's case, 90% of the nodes were only edited once, and the last edit represents > 85% of all edits, so this approximation was found to be appropriate. You may want to test your own assumptions; [see this article to learn how.](http://prabhasp.github.io/OSMTimeLapseR/demo/CheckingAssumptions.html).

Create your own
---
 * To see how the above visualizations were produced, see the corresponding demos: [GIF](demo/AnimateGIF.html), [HTML](demo/AnimateHTML.html).
 * To work with your own datasets, see [this demo](demo/AnimateFromFile.html)
 * To create your own custom visualization, see [this demo](demo/CustomizingVisualizations.html)

Installation instructions
---
 * Install R ([Mac](http://cran.r-project.org/bin/macosx/), [Windows](http://cran.r-project.org/bin/windows/base/), [Other](http://cran.r-project.org/bin/)). I also recommend installing [RStudio](https://www.rstudio.com/ide/download/).
 * Install OSMTimeLapseR by typing the following in your R console:
   * ```install.packages('devtools'); require(devtools); install_github("prabhasp/OSMTimeLapseR")``` 
 * Install Java (required by R's `OpenStreetMap` package).
 * If you want to work with your own files, install [http://wiki.openstreetmap.org/wiki/Osmconvert](osmconvert)
 * If you want to make GIFs, install [ImageMagick](http://www.imagemagick.org/)
