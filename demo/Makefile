all: kathmandu_yearly.gif kathmandu_monthly.html sochi_yearly.gif ../index.html
../index.html: ../README.md
	markdown ../README.md > ../index.html
kathmandu_yearly.gif: AnimateGIF.Rmd
	echo 'require(knitr); knit2html("AnimateGIF.Rmd")' | R --no-save
sochi_yearly.gif: AnimateFromFile.Rmd
	echo 'require(knitr); knit2html("AnimateFromFile.Rmd")' | R --no-save
kathmandu_monthly.html: AnimateHTML.Rmd
	echo 'require(knitr); knit2html("AnimateHTML.Rmd")' | R --no-save
