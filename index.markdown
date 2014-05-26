---
layout: default
title: OSMTimeLapseR Home
---
Welcome to OSMTimeLapseR. This package helps you visualize the edits to OSM in your community. It was developed based on a request from the OSM Nepal community, whose work growing OSM in Kathmandu can be seen below. But you can use it to create visualize growth in your own community -- see the "Create your own" section below.

![]({{site.baseurl}}/demo/kathmandu_yearly.gif)

A monthly visualization is [here]({{site.baseurl}}/demo/kathmandu_monthly.html).

**Note**: We are NOT visualizing all changes to OSM. We are only visualizing the last changed date of all nodes that still exist in OSM. This under-reports changes, and is slightly biased towards later dates. In Kathmandu's case, 90% of the nodes were only edited once, and the last edit represents > 85% of all edits, so this approximation was found to be appropriate. You may want to test your own assumptions; [see this article to learn how.]({{site.baseurl}}/examples/check-assumptions.html).

Create your own
---
 * To see how the above visualizations were produced, see the corresponding demos: [GIF]({{site.baseurl}}/examples/gif-example.html), [HTML]({{site.baseurl}}/examples/html-example.html).
 * To work with your own datasets, see [this example]({{site.baseurl}}/examples/use-your-own-data.html)
 * To create your own custom visualization, see [this example]({{site.baseurl}}/examples/custom.html)

Installation instructions
---
 * Install R ([Mac](http://cran.r-project.org/bin/macosx/), [Windows](http://cran.r-project.org/bin/windows/base/), [Other](http://cran.r-project.org/bin/)). I also recommend installing [RStudio](https://www.rstudio.com/ide/download/).
 * Install OSMTimeLapseR by typing the following in your R console:
   * ```install.packages('devtools'); require(devtools); install_github("prabhasp/OSMTimeLapseR")``` 
 * Install Java (required by R's `OpenStreetMap` package).
 * If you want to work with your own files, install [osmconvert](http://wiki.openstreetmap.org/wiki/Osmconvert)
 * If you want to make GIFs, install [ImageMagick](http://www.imagemagick.org/)

Credits
---
 * This work wouldn't exist without the work of the OSM volunteers in Nepal and the incredible work they have been doing. All inspiration is drawn from them.
 * Mike Migurski's [Metro Extracts](http://metro.teczno.com/) and [osmconvert](http://wiki.openstreetmap.org/wiki/Osmconvert) have helped this work along greatly.
 * This work owes quite a bit to the R software world, including Hadley Wickam's packages (which make R pleasant to work with) and Yihui Xie's animation package.
 * Thanks to Robert Banick, Nama Budhathoki, Nate Smith, Robert Soden, Daniel Wood and others from the OSM community for early stage feedback and encouragement.

