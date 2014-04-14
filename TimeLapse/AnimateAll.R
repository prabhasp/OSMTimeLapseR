##### LOAD DATA
source("TimeLapse/TimeLapseDT.R")
nd <- readRDS("TimeLapse/node_data.RDS")
stopifnot("data.table" %in% class(nd))

TIME_UNIT = "year"
saveHTML({
    ani.options(interval = 0.5, verbose=FALSE) 
    make_time_lapse_dt(nd, time_unit=TIME_UNIT)
}, 
    img.name = paste("timelapse", TIME_UNIT,"els",sep="_"), 
    ani.height = 600, ani.width = 1000,
    single.opts = paste("'controls':", "['first', 'previous', 'play', 'next', 'last', 'speed'],", "'delayMin': 0"),
    outdir = "TimeLapse", 
    htmlfile=paste(TIME_UNIT, "html", sep="."), imgdir=TIME_UNIT, 
    title="Edits to OSM in Kathmandu",
    description="Edits to OSM in Kathmandu. Points appear on the map (in red) on the week
when they were last edited, and stay on in gray.")

saveGIF({
    make_time_lapse_dt(nd, time_unit="year")
}, movie.name="kathmandu_yearly.gif", interval=0.5,
    img.name = paste("timelapse", TIME_UNIT,"els",sep="_"),
    imgdir=TIME_UNIT, outdir=normalizePath('TimeLapse'))
