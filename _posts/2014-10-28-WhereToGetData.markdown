---
layout: post
title: Where to get OSM data
published: true
status: publish
permalink: help/getting-data.html
---

To use the OSMTimeLapseR package to animate edits in your own community, you will need to download data for the region you are interested in. Here are a few options:

### Bounding Box based exports

If you want to export data for a specific bounding box only, here are some options:

 * Use the [Export](http://www.openstreetmap.org/export) feature of the **OSM website** to download a `.osm` file.
 * If you are already working with the data in **JOSM**, make sure to do a `File > Update Data`, and then just `File > Save As` an `.osm` file.

After you have these `.osm` files, you can follow the [how to use your own data](examples/use-your-own-data.html) tutorial.

Note: **OSMBBike** exports will not work, because they do not save the timestamp metadata that our visualization needs.


### City-level exports


The **[Metro Extracts](https://mapzen.com/metro-extracts/)** project creates weekly exports of OSM data from a range of cities around the world. If your city's data is available, download away! (I recommend using the `OSM PBF` files, since they are the smallest, and OSMTimeLapseR can read them.) If not, you can edit [this file](https://github.com/mapzen/metroextractor-cities/blob/master/cities.json) to add your city and send them a pull request, or [open an issue](https://github.com/mapzen/metroextractor-cities/issues) on their github page.

### Country and Continent-level exports

**Use History Files!!** (Instructions coming soon)

For country and continent-level exports, you have several options, such as [Geofabrik downloads](http://download.geofabrik.de/), and [API-based options](http://wiki.openstreetmap.org/wiki/Downloading_data)
