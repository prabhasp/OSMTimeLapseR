##### LOAD DATA
source("TimeLapse/TimeLapseDT.R")
nd <- readRDS("TimeLapse/node_data.RDS")
node_data_table <- data.table(nd)

saveHTML({
    ani.options(interval = 0.2, nmax = length(unique(node_data_table$week)), verbose=FALSE) 
    #make_time_lapse_dt(swplot_dt)(node_data_table)
}, 
    img.name = paste("timelapse", nrow(node_data_table),"els",sep="_"), 
    ani.height = 600, ani.width = 1000,
    single.opts = paste("'controls':", "['first', 'previous', 'play', 'next', 'last', 'speed'],", "'delayMin': 0"),
    outdir = "TimeLapse", htmlfile="all.html", imgdir="all", 
    title="Edits to OSM in Kathmandu",
    description="Edits to OSM in Kathmandu. Points appear on the map (in red) on the week
when they were last edited, and stay on in gray.")
