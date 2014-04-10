all: TimeLapseFromNodeCSV.html index.html
index.html TimeLapseFromNodeCSV.html: TimeLapseFromNodeCSV.Rmd
	echo 'require(knitr); knit2html("TimeLapseFromNodeCSV.Rmd")' | R --no-save
KathmanduExplorations.html: KathmanduExplorations.Rmd
	echo 'require(knitr); knit2html("KathmanduExplorations.Rmd")' | R --no-save
