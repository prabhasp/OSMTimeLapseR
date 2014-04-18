### FUNCTIONS FOR PLOTTING
require(ggplot2); require(lubridate); require(stringr); require(gridExtra); require(animation); require(data.table); require(OpenStreetMap)
blank_theme <- function() {
    theme(axis.text=element_blank(), axis.ticks = element_blank(), 
          axis.title=element_blank(), panel.grid=element_blank(), 
          panel.background=element_rect(fill='white'), legend.position = "none") 
}
single_plot <- function(before, this, total_by_timeunit, timeunit_pretty, basemap=NULL, unit_for_bargraph='identity') {
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
make_time_lapse_dt <- function(node_data_table, time_unit='week', single_plot_fun=single_plot, verbose=FALSE) { 
    stopifnot(all(c("lat", "lon", "timestamp") %in% names(node_data_table)))
    ## basemap
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
    
    ## data
    if(verbose) print("Aggregating time unit ...")
    node_data_table <- na.omit(node_data_table)
    node_data_table[, timeunit:=floor_date(timestamp, time_unit)]
    setkey(node_data_table, timeunit)
    total_by_timeunit <- node_data_table[, .N, by=timeunit]
    if(verbose) cat("Generating plots ")
    for (current_timeunit in sort(unique(node_data_table$timeunit))) {
        before = node_data_table[timeunit < current_timeunit]
        this = node_data_table[timeunit==current_timeunit]
        if(verbose) cat(".")
        single_plot_fun(before=before, this=this,
                        total_by_timeunit=total_by_timeunit, 
                        timeunit_pretty=toupper(time_unit),
                        basemap=basemap)
        ani.pause()
    }
    cat('\n')
}
