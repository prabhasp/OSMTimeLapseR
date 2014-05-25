---
layout: post
title: Yearly timelapse of Kathmandu, as a GIF
published: true
status: publish
categories: [Examples]
---
 
In this brief demo, we will show you how to use the OSMTimeLapser package to create a GIF-based timelapse of the built-in Kathmandu dataset. Once you install OSMTimeLapser [1], you can type the same commands to create your own gif. Note that you can change 'year' to 'month' or 'week', the filename, output directory [2], and interval of switching from one picture to another. For more options, see `?saveGIF`.
 

    require(OSMTimeLapseR)  ## Load the library
    data(kathmandu_2013)  ## Load the built-in dataset kathmandu_2013 into your R environment
    
    saveGIF({
        ## Create a GIF using the animate package. Note: requires ImageMagick.
        time_lapse(kathmandu_2013, "year", verbose = FALSE)
    }, movie.name = "kathmandu_yearly.gif", interval = 1, outdir = normalizePath("../demo/"))

![]({{site.baseurl}}/demo/kathmandu_yearly.gif)
 
[1] To install OSMTimeLapseR, copy and paste the following into an R console. You will also need to install Java (for the downloading and re-projecting the basemap) and ImageMagick (for GIF outputs).
```install.packages('devtools'); require(devtools); install_github("prabhasp/OSMTimeLapseR")```
 
[2] Quick note, if you want to change the output directory as a relative path (eg. "demo/"), you have to normalize the path before passing it into saveGIF. Example: `outdir = normalizePath('demo')`.
