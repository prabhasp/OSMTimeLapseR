all: ../index.html kathmandu_yearly.gif sochi_yearly.gif *.html 
../index.html: ../README.md
	markdown ../README.md > ../index.html
kathmandu_yearly.gif AnimateGIF.html: AnimateGIF.Rmd
	echo 'require(knitr); knit2html("AnimateGIF.Rmd")' | R --no-save
sochi_yearly.gif AnimateFromFile.html: AnimateFromFile.Rmd
	echo 'require(knitr); knit2html("AnimateFromFile.Rmd")' | R --no-save
kathmandu_monthly.html AnimateHTML.html: AnimateHTML.Rmd
	echo 'require(knitr); knit2html("AnimateHTML.Rmd")' | R --no-save
CheckingAssumptions.html: CheckingAssumptions.Rmd
	echo 'require(knitr); knit2html("CheckingAssumptions.Rmd")' | R --no-save
