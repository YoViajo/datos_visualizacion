library(foreign)
deaths=read.dbf("E:/LAB/r/snow_cholera/SnowGIS/Cholera_Deaths.dbf")

library(OpenStreetMap)
map = openmap(c(lat= 51.516,   lon= -.141),
              c(lat= 51.511,   lon= -.133))
map=openproj(map, projection = "+init=epsg:27700") 
plot(map)
points(deaths@coords,col="red", pch=19, cex=.7 )

# compute the density
X=deaths@coords
kde2d <- bkde2D(X, bandwidth=c(bw.ucv(X[,1]),bw.ucv(X[,2])))

# get a nice gradient
clrs=colorRampPalette(c(rgb(0,0,1,0), rgb(0,0,1,1)), alpha = TRUE)(20)
