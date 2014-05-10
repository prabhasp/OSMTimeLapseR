 
**High Priority**
 * ~~figure out GIF outputting~~
 * ~~add a OSM baselayer (mapbox streets)~~
    * ~~[bug] frame of reference (ie, bbox) shouldn't change over time~~
 * ~~customize time unit of aggregation~~
 * add OSM credit line
 * make basemap not fuzzy (ie, don't reproject)

**Medium Priority**
 * ~~easy to deploy on X.osm~~
 * ~~use osmconvert rather than custom osm_parser~~
 * ~~package into an R package~~
   * ~~figure out how to package osmconvert along with R package
   (same, with osm_parser)~~
 * add custom annotations 


**Argh** *:(harder than need to be items)*
 * change how the histogram is highlighted (add a vertical line that spans the whole bottom graph)
   -- why isn't geom_vline working well with time scales?
 * custom baselayer

**One Day**
 * customize each visualization 
 * polygon / line support (lot of work)
 * user attribution (can of many worms)
