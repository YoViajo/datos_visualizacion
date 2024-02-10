library(HistData)
data(Snow.deaths)
data(Snow.streets)

# visualize the deaths, on a simplified map, with the streets (here simple grey segments
plot(Snow.deaths[,c("x","y")], col="red", pch=19, cex=.7,xlab="", ylab="", xlim=c(3,20), ylim=c(3,20))
slist <- split(Snow.streets[,c("x","y")],as.factor(Snow.streets[,"street"]))
invisible(lapply(slist, lines, col="grey"))

# add isodensity curves (estimated using kernels)
require(KernSmooth)
kde2d <- bkde2D(Snow.deaths[,2:3], bandwidth=c(0.5,0.5))
contour(x=kde2d$x1, y=kde2d$x2,z=kde2d$fhat, add=TRUE)
