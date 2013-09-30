all:
	echo 'require(knitr); knit2html("KathmanduExplorations.Rmd")' | R --no-save
