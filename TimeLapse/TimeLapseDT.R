### FUNCTIONS FOR PLOTTING
require(ggplot2); require(lubridate); require(stringr); require(gridExtra); require(animation); require(data.table)
blank_theme <- function() {
    theme(axis.text=element_blank(), axis.ticks = element_blank(), 
          axis.title=element_blank(), panel.grid=element_blank(), 
          panel.background=element_rect(fill='white'), legend.position = "none") 
}
swplot_dt <- function(before, this, total_by_week) {
    this_week <- unique(this$week)
    stopifnot(length(this_week) == 1) 
    p1 <- ggplot() + 
        geom_point(data=before, aes(x=lon, y=lat), color="grey50", size=1, alpha=0.5) +
        geom_point(data=this, aes(x=lon, y=lat), color="red", size=1, alpha=0.8) +
        labs(title=paste('Week of',this_week)) + coord_map(projection='mercator') +
        blank_theme()
    total_by_week$is_this_week = total_by_week$week == this_week
    p2 <- ggplot(data=total_by_week, aes(x=week, y=N, fill=is_this_week)) + 
        geom_bar(stat='identity') +
        theme_minimal() + theme(legend.position='none', axis.line=element_blank()) + 
        labs(y="# of nodes", x="Week") +
        scale_fill_manual(values=c("grey50", "red")) +
        coord_trans(y='sqrt')
    grid.arrange(p1, p2, heights=c(4,1))
}
make_time_lapse_dt <- function(single_plot) { 
    function(node_data_table) {
        total_by_week <- node_data_table[, .N, by=week]
        for (current_week in sort(unique(node_data_table$week))) {
            single_plot(before=node_data_table[week < current_week], 
                      this=node_data_table[week==current_week],
                      total_by_week=total_by_week)
            ani.pause()
        }
    }
}
