# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

## Mapas coropléticos: Resultados de Referendo Constitucional 2016 en Bolivia
##
## Basado en:
## Ref: https://rstudio-pubs-static.s3.amazonaws.com/324400_69a673183ba449e9af4011b1eeb456b9.html
## An Introduction to Choropleth maps in R: Basic Graphics, GISTools, tmap, spplot, ggplot2 and Leaflet



library(RColorBrewer)
library(rgdal)
library(sf)

# GRÁFICOS BASE
bol16 <- readOGR(dsn="dat", layer = "ref_const_2016_munic_crr")

mycolours <- brewer.pal(6, "RdYlGn")
mybreaks <- c(0, 30, 40, 50, 60, 70, 100)
cut(bol16$referend_4, mybreaks)
mycolourscheme <- mycolours[findInterval(bol16$referend_4, vec = mybreaks)]
plot(bol16, col = mycolourscheme, main = "Referendo constitucional 2016 - % Voto Sí", cex = 5)
legend(-100, 50, legend = levels(cut(bol16$referend_4, mybreaks)), fill = mycolourscheme, cex = 0.8, title = "% vote Sí")


## SSPLOT
library(sp)
library(RColorBrewer)
mycolours <- brewer.pal(6, "RdYlGn")
spplot(bol16,"referend_4", par.settings = list(axis.line = list(col ="transparent")), main = "Referendo constitucional 2016 - % Voto Sí", cuts = 6, col ="transparent", col.regions = mycolours)


## GISTools
library(GISTools)

myshading = auto.shading(bol16$referend_4, n=6,
                         cols=brewer.pal(6, "RdYlGn"))
choropleth(bol16, bol16$referend_4,shading=myshading, main = "Referendo constitucional 2016 - % Voto Sí")
choro.legend(px='bottomleft', sh=myshading,fmt="%4.1f",cex=0.8)


## TMAP
library(tmap)

# La opción tmap_options fue necesaria para corregir un error en la geometría
tm_shape(bol16) + tm_polygons(col='referend_4', title = "Referendo constitucional 2016 - % Voto Sí", palette = "Spectral") + tm_style("classic") + tm_scale_bar(position = c("right", "bottom")) 


# corrección de gráfico inicial
library(ggplot2)
library(scales)
library(ggmap)
library(viridis)
bol16@data$id <- rownames(bol16@data)
newBO <- fortify(bol16, region = "id")
newdf <- merge(newBO, bol16@data, by = "id")
Myplot <- ggplot() +
  
  geom_polygon(data = newdf, aes(fill = referend_4, 
                                 x = long, 
                                 y = lat, 
                                 group = group)) +
  theme_nothing(legend = TRUE) + coord_map() + ggtitle("Referendo constitucional 2016 - % Voto Sí") + theme(plot.title = element_text(hjust =0.5))

NicerPlot <- Myplot + scale_fill_viridis(option = "magma", direction = -1)
NicerPlot
