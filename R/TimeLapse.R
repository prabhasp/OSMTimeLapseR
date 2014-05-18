#' Return a blank ggplot theme, good for overlaying maps on top of.
#' @param bgfill Background fill color.
blank_theme <- function(bgfill = 'white') {
    theme(axis.title.y = element_blank(), axis.title.y = element_text(hjust = 1),
          axis.text = element_blank(), axis.ticks = element_blank(), legend.position = "none",
          panel.grid = element_blank(), panel.background = element_rect(fill = bgfill)) 
}
#' Default plot for a single timeunit worth of data (one frame of animation).
#' 
#' @param before data.table for all the (uninclusive) previous timeunit data.
#' @param this data.table for this timeunit's data.
#' @param total_by_timeunit data.table with a summary of total observations per timeunit.
#' @param timeunit_pretty A pretty printed version of the timeunit (eg. Week for week).
#' @param basemap A ggplot object representing the basemap.
#' @param base_color The color to plot "before" points in, Default is grey50.
#' @param highlight The color to plot "this time_unit" points in, Default is red.
#' @param bg_color The color of the background panel, Default is white.
#' @param size The default point size, Default is 1.
#' @param alpha The default alpha for highlighted values. Default is .8. For background points, alpha^2 is used.
#' @export
plot_single_timeunit <- function(before, this, total_by_timeunit, timeunit_pretty, basemap = NULL,
        base_color = 'grey50', highlight = 'red', bg_color = 'white', size = 1, alpha = 0.8) {
    this_timeunit <- unique(this$timeunit)
    stopifnot(length(this_timeunit) == 1) 
    p1 <- basemap + 
        geom_point(data = before, aes(x = lon, y = lat), color = base_color, size = size, alpha = alpha^2) +
        geom_point(data = this, aes(x = lon, y = lat), color = highlight, size = size, alpha = alpha) +
        labs(title = paste(timeunit_pretty,this_timeunit, sep = ": ")) +  
        blank_theme(bg_color) +
        labs(x = "Data © OpenStreetMap contributors")
    total_by_timeunit$is_this_timeunit = total_by_timeunit$timeunit == this_timeunit
    p2 <- ggplot(data = total_by_timeunit, aes(x = timeunit, y = N, fill = is_this_timeunit)) + 
        geom_bar(stat = 'identity') +
        theme_minimal() + theme(legend.position = 'none', axis.line = element_blank()) + 
        labs(y = "# of Nodes", x = timeunit_pretty) +
        scale_fill_manual(values = c(base_color, highlight)) +
        geom_vline(xintercept = as.numeric(this_timeunit), color=highlight)
    grid.arrange(p1, p2, heights = c(4,1))
}

#' Function to create a time lapse animation out of a data table of nodes.
#' 
#' @param node_data_table  data.table containing, at least lat, lon, and timestamp. lat + lon must
#'                         be in WGS84. timestamp must be of type R POSIXct.
#' @param time_unit        Time unit for each frame. As per lubridate::round_date, should be one of
#'                              "second","minute","hour","day", "week", "month", or "year."
#' @param plot_single_timeunit_FUN Function for plotting a single frame. See plot_single_timeunit for
#'                              details on what the function should look like.
#' @param basemap_type     Which OSM basemap to download? type must be supported by OpenStreetMap
#'                              package. Default is mapbox. Pass "none" to skip basemap.
#' @param verbose          A flag to determine whether progress of the time lapse making process are printed
#'                              out to the console.
#' @param ... Other parameters to be passed to plot_single_timeunit. Eg. highlight, alpha, size.
#' @export
time_lapse <- function(node_data_table, time_unit = 'year', basemap_type = "mapbox",
                       plot_single_timeunit_FUN = plot_single_timeunit, verbose = FALSE, ...) { 
    stopifnot(all(c("lat", "lon", "timestamp") %in% names(node_data_table)))
    ## basemap
    basemap <- get_ggbasemap(lat_range = range(node_data_table$lat, na.rm = T),
                           lon_range = range(node_data_table$lon, na.rm = T), 
                           type = basemap_type, verbose = verbose)
    
    ## data
    if(verbose) print("Aggregating time unit ...")
    node_data_table <- na.omit(node_data_table)
    node_data_table[, timeunit := floor_date(timestamp, time_unit)]
    setkey(node_data_table, timeunit)
    total_by_timeunit <- node_data_table[, .N, by = timeunit]
    if(verbose) cat("Generating plots ")
    for (current_timeunit in sort(unique(node_data_table$timeunit))) {
        before = node_data_table[timeunit < current_timeunit]
        this = node_data_table[timeunit == current_timeunit]
        if(verbose) cat(".")
        plot_single_timeunit_FUN(before = before, this = this,
                                 total_by_timeunit = total_by_timeunit, 
                                 timeunit_pretty = R.utils::capitalize(time_unit),
                                 basemap = basemap, ...)
        ani.pause()
    }
    if(verbose) cat('\n')
}

#' Get basemap using the OpenStreetMap package. Also cache it into a filename unless
#' cache = FALSE, downloading+projecting tiles takes a while so caching generally makes sense.
#' 
#' @param lat_range A vector of minimum and maximum latitude to download basemap for.
#' @param lat_range A vector of minimum and maximum latitude to download basemap for.
#' @param type      What kind of basemap? See options in OpenStreetMap package. "none" = blank.
#' @param num_tiles How many tiles (at least) to download?
#' @param cache     Whether or not to cache the downloaded map. TRUE by default. Saves
#'                          an .RDS file that encodes latrange/lonrange.
#' @param verbose   Prints message about what is being done if TRUE. FALSE by default.
#' @export
#' @return A ggplot object.
get_ggbasemap <- function(lat_range, lon_range, num_tiles = 9, type = "mapbox", 
                        cache = TRUE, verbose = FALSE) {
    if(type == "none") { 
        return(ggplot() + expand_limits(x = lon_range, y = lat_range) + coord_map())
    }
    fname <- sprintf("OSMBasemap_%s_%s.RDS", type, paste0(lat_range, lon_range, collapse=""))
    if(file.exists(fname) & cache) {
        if(verbose) print("Reading map from file ...")
        basemap <- readRDS(fname)
    } else {
        if(verbose) print("Downloading map ...")
        basemap <- openmap(upperLeft = c(max(lat_range), min(lon_range)), 
                           lowerRight = c(min(lat_range), max(lon_range)),
                           type = type, minNumTiles = num_tiles)
        ## openmap's output is in "openstreetmap" mercator. need to convert to wgs
        ## todo: project data instead?
        if(verbose) print("Projecting map ...")
        basemap <- openproj(basemap, CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))
        if(cache) saveRDS(basemap, fname)
    }
    autoplot(basemap)
}

#' Create a data.table with columns as specified, given osm file.
#' 
#' OSM file can be a .csv file, a .osm file or a .pbf file.
#' If .osm or .pbf file are input, then osmconvert must be the path to
#' the osmconvert command. A .csv file with an identical basename will be created.
#' @param osm_file The osm_file to process. Can be a .csv, .osm, or .pbf file.
#' @param osmconvert Path to the osmconvert command-line utility. See
#'          http://wiki.openstreetmap.org/wiki/Osmconvert for installation.
#' @param columns Columns that osmconvert should output. Syntax from osmconvert.
#' @export
#' @return A data.table, with lat, lon, and timestamp columns.
read_OSM <- function(osm_file, osmconvert = 'osmconvert', columns = '@lat @lon @timestamp') {
    ## Verify that osm_file exists
    osm_file = normalizePath(osm_file)
    if(!file.exists(osm_file)) { stop("Could not find file: ", osm_file)}
    ## If input file is osm (xml) or pbf, make csv file in the same directory / with the same name
    if(tools::file_ext(osm_file) %in% c('osm', 'pbf')) {
        ## First, verify that osmconvert can be run from the command line
        cmd.fun = if (.Platform$OS.type == 'windows') shell else system
        tryCatch(cmd.fun(sprintf('%s -h', osmconvert), intern = TRUE, ignore.stdout = TRUE), 
                 error = function(e) { stop("Could not find command: ", osmconvert )})
        ## Time to convert to csv. Pick the same basename and directory as the input file.
        osm_file_basename = tools::file_path_sans_ext(osm_file)
        cmd.fun(sprintf('%s %s --csv="%s" --csv-separator="," -o=%s.csv',
                        osmconvert, osm_file, columns, osm_file_basename))
        osm_file = sprintf("%s.csv", osm_file_basename)
        stopifnot(file.exists(osm_file)) # Verify that output happened correctly
    } else if (tools::file_ext(osm_file) != 'csv') {
        stop("File with that extension not support. Please report a bug if it should be.")
    }
    ## Finally, read the csv file, convert into a data.table, convert timestamp, and return
    dt = data.table(setNames(read.csv(osm_file, header = F), 
                             stringr::str_replace(unlist(strsplit(columns, " ")), "@", "")))
    dt$timestamp = ymd_hms(dt$timestamp) #dt[, timestamp := ymd_hms(timestamp)]
    dt
}