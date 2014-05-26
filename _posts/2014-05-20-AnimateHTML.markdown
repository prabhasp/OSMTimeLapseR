---
layout: post
title: Monthly timelapse of Kathmandu, as HTML file
published: true
status: publish
permalink: examples/html-example.html
---
 
In this brief demo, we will show you how to use the OSMTimeLapser package to create a html-based timelapse of the built-in Kathmandu dataset. Once you install OSMTimeLapser [1], you can type the same commands to create your own gif. Note that you can change 'month' to 'year' or 'week', the filename, output directory, and interval of switching from one picture to another. For more options, see `?saveHTML` and `?ani.options`.
 

    ## Load the library
    require(OSMTimeLapseR)
    ## Load the built-in dataset kathmandu_2013 into your R environment
    data(kathmandu_2013)
    
    ## Create an HTML animation using the animate package. For more options, see
    ## ?saveHTML
    saveHTML({
        time_lapse(kathmandu_2013, "month", verbose = FALSE)
    }, title = "Edits to OSM in Kathmandu", ani.height = 600, ani.width = 1000, 
        single.opts = paste("'controls':", "['first', 'previous', 'play', 'next', 'last', 'speed']"), 
        loop = FALSE, interval = 0.5, outdir = normalizePath("../demo/"), htmlfile = "kathmandu_monthly.html")

<iframe src="{{site.baseurl}}/demo/kathmandu_monthly.html" width="1100" height="900" frameBorder="0"> </iframe>
 
[1] To install OSMTimeLapseR, copy and paste the following into an R console. You will also need to install Java (for the downloading and re-projecting the basemap) and ImageMagick (for creating GIFs).
```install.packages('devtools'); require(devtools); install_github("prabhasp/OSMTimeLapseR")```
