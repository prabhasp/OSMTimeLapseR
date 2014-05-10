#' Return a blank ggplot theme, good for overlaying maps on top of.
#' @param bgfill Background fill color.
blank_theme <- function(bgfill='white') {
    theme(axis.text=element_blank(), axis.ticks = element_blank(), 
          axis.title=element_blank(), panel.grid=element_blank(), 
          panel.background=element_rect(fill=bgfill), legend.position = "none") 
}
#' Default plot for a single timeunit worth of data (one frame of animation).
#' 
#' @param before data.table for all the (uninclusive) previous timeunit data.
#' @param this data.table for this timeunit's data.
#' @param total_by_timeunit data.table with a summary of total observations per timeunit.
#' @param timeunit_pretty A pretty printed version of the timeunit (eg. Week for week).
#' @param basemap A basemap to plot data on top of. Must be a ggplot object.
#' @export
plot_single_timeunit <- function(before, this, total_by_timeunit, timeunit_pretty, basemap=NULL) {
    this_timeunit <- unique(this$timeunit)
    stopifnot(length(this_timeunit) == 1) 
    p1 <- if(is.null(basemap)) { ggplot() } else { autoplot(basemap) }
    p1 <- p1 + 
        geom_point(data=before, aes(x=lon, y=lat), color="grey50", size=1, alpha=0.5) +
        geom_point(data=this, aes(x=lon, y=lat), color="red", size=1, alpha=0.8) +
        labs(title=paste(timeunit_pretty,this_timeunit, sep=": ")) + # coord_map(projection='mercator') +
        blank_theme()
    total_by_timeunit$is_this_timeunit = total_by_timeunit$timeunit == this_timeunit
    p2 <- ggplot(data=total_by_timeunit, aes(x=timeunit, y=N, fill=is_this_timeunit)) + 
        geom_bar(stat='identity') +
        theme_minimal() + theme(legend.position='none', axis.line=element_blank()) + 
        labs(y="# of Nodes", x=timeunit_pretty) +
        scale_fill_manual(values=c("grey50", "red"))
    grid.arrange(p1, p2, heights=c(4,1))
}

#' Default plot for a single timeunit worth of data (one frame of animation).
#' 
#' @param node_data_table  data.table containing, at least lat, lon, and time_stamp. lat + lon must
#'                         be in WGS84. time_stamp must be of type R POSIXct.
#' @param time_unit        Time unit for each frame. As per lubridate::round_date, should be one of
#'                              "second","minute","hour","day", "week", "month", or "year."
#' @param plot_single_timeunit_FUN Function for plotting a single frame. See plot_single_timeunit for
#'                              details on what the function should look like.
#' @param verbose          A flag to determine whether progress of the time lapse making process are printed
#'                              out to the console.
#' @export
time_lapse <- function(node_data_table, time_unit='week', plot_single_timeunit_FUN=plot_single_timeunit,
                       verbose=FALSE, downloadBaseMap=TRUE) { 
    stopifnot(all(c("lat", "lon", "time_stamp") %in% names(node_data_table)))
    ## basemap
    if(downloadBaseMap) {
        if(verbose) print("Downloading map ...")
        lat_range <- range(node_data_table$lat, na.rm=T)
        lon_range <- range(node_data_table$lon, na.rm=T)
        basemap <- openmap(upperLeft=c(max(lat_range), min(lon_range)), 
                           lowerRight=c(min(lat_range),max(lon_range)),
                           type='mapbox', minNumTiles=9)
        ## openmap's output is in "openstreetmap" mercator. need to convert to wgs
        ## todo: project data instead?
        if(verbose) print("Projecting map ...")
        basemap <- openproj(basemap, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
    } else {
        basemap <- NULL
    }
    
    ## data
    if(verbose) print("Aggregating time unit ...")
    node_data_table <- na.omit(node_data_table)
    node_data_table[, timeunit:=floor_date(time_stamp, time_unit)]
    setkey(node_data_table, timeunit)
    total_by_timeunit <- node_data_table[, .N, by=timeunit]
    if(verbose) cat("Generating plots ")
    for (current_timeunit in sort(unique(node_data_table$timeunit))) {
        before = node_data_table[timeunit < current_timeunit]
        this = node_data_table[timeunit==current_timeunit]
        if(verbose) cat(".")
        plot_single_timeunit_FUN(before=before, this=this,
                                 total_by_timeunit=total_by_timeunit, 
                                 timeunit_pretty=toupper(time_unit),
                                 basemap=basemap)
        ani.pause()
    }
    if(verbose) cat('\n')
}

#' Create a data.table with lat,lon,time_stamp given an osm file.
#' OSM file can be a .csv file, a .osm file or a .pbf file.
#' If .osm or .pbf file are input, then osmconvert must be the path to
#' the osmconvert command. A .csv file with an identical basename will be created.
#' 
#' @param osm_file The osm_file to process. Can be a .csv, .osm, or .pbf file.
#' @param osmconvert Path to the osmconvert command-line utility. See
#'          http://wiki.openstreetmap.org/wiki/Osmconvert for installation.
#' @export
#' @return A data.table, with lat, lon, and time_stamp columns.
data_table_from_OSM_file <- function(osm_file, osmconvert='osmconvert') {
    ## Verify that osm_file exists
    osm_file = normalizePath(osm_file)
    if(!file.exists(osm_file)) { stop("Could not find file: ", osm_file)}
    ## If input file is osm (xml) or pbf, make csv file in the same directory / with the same name
    if(tools::file_ext(osm_file) %in% c('osm', 'pbf')) {
        ## First, verify that osmconvert can be run from the command line
        cmd.fun = if (.Platform$OS.type == 'windows') shell else system
        tryCatch(cmd.fun(sprintf('%s -h', osmconvert), intern=TRUE, ignore.stdout=TRUE), 
                 error = function(e) { stop("Could not find command: ", osmconvert )})
        ## Time to convert to csv. Pick the same basename and directory as the input file.
        osm_file_basename = tools::file_path_sans_ext(osm_file)
        cmd.fun(sprintf('%s %s --csv="@lat @lon @timestamp" --csv-separator="," -o=%s.csv',
                        osmconvert, osm_file, osm_file_basename))
        osm_file = sprintf("%s.csv", osm_file_basename)
        stopifnot(file.exists(osm_file)) # Verify that output happened correctly
    } else if (tools::file_ext(osm_file) != 'csv') {
        stop("File with that extension not support. Please report a bug if it should be.")
    }
    ## Finally, read the csv file, convert into a data.table, convert time_stamp, and return
    dt = data.table(setNames(read.csv(osm_file, header=F), c("lat", "lon", "time_stamp")))
    dt$time_stamp = ymd_hms(dt$time_stamp) #dt[, time_stamp := ymd_hms(time_stamp)]
    dt
}