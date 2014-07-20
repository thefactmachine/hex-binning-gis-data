library('hexbin')
library("classInt")
library("RCurl")
rm(list=ls())
#=====================================================================
fnZero <- function(fltNumber) {
#if negative number return '0'
    if (fltNumber < 0) { fltReturn <- 0 }
    else {fltReturn <- fltNumber}
    return(fltReturn)
}
#get the file from github. getURL takes care of R's https issue
x <- getURL("https://raw.githubusercontent.com/thefactmachine/hex-binning-gis-data/master/xyz.csv")
df <- read.csv(text = x)

# clean up negative number, set them to zero.
df$Z <- sapply(df$Z, fnZero)
#clear existing plot
if (names(dev.cur()) == "RStudioGD") { dev.off(dev.list()["RStudioGD"]) }
#create hexgrid
hbin<-hexbin(df$X, df$Y,xbins=40,IDs=TRUE)
#create viewport (i.e plot dimensions, aspect...)
hvp <- hexViewport(hbin)

#default is counts hexbins. This is overidden and means are calculated.
mtrans<-hexTapply(hbin,df$Z,mean,na.rm=TRUE)

#scale means calculated to 0..1
minT <- min(mtrans)
maxT <- max(mtrans)
rangeT <- maxT - minT
mtransScale <- (mtrans - minT) / rangeT

#set the colors, number intervals, interval location
cr <- colorRampPalette(c('#FFFFFF','#0000CC'))
#ci <- classIntervals(mtransScale, n = 30, style = "quantile")
ci <- classIntervals(mtransScale, n = 40, style = "fisher")

#now we can plot.
pushHexport(hvp)
grid.hexagons(hbin,style='colorscale',pen=0,border= 'white',use.count=FALSE,
              minarea = 0.04, maxarea = 1, mincnt = 1, maxcnt = 3000,
              cell.at=mtrans, colramp=cr, colorcut= ci$brks)

popViewport()

#copy device output to pdf
dev.copy2pdf(file="hexgrid.pdf")
