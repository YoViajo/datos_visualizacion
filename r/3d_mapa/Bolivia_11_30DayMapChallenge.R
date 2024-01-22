# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

## Mapa coroplético 3D

## Basado en:
# Ref: https://twitter.com/leeolney3/status/1458676526556364803?t=RP14f5g5M0O2dvEtJ8Gy9g&s=09
# Ref: https://gist.github.com/leeolney3/3881840a2907cd1805506893cb843f25
# Representación 3D de gráfico coroplético de Bolivia

library(tidyverse)
library(janitor)
library(sf)
library(rayshader)
library(rgdal)

# Importar datos. Se importa polígonos con atributos, preparados en QGIS 
datos = readOGR("dat/cobertura_municipal_energiaelectrica_2016.geojson")
bol_cob <- st_as_sf(datos)

# ggplot 2d
p1 = ggplot() +
  geom_sf(data=bol_cob, aes(fill=Cob_2016)) +
  colorspace::scale_fill_continuous_sequential(palette="Peach", #batlow
                                               limits=c(16.75,100.00),
                                               breaks=c(16.75,52.27,72.52,88.12,100.00),
                                               labels=c("17%","52%","73%","88%","100%")) +
  theme_void() +
  theme(plot.margin=margin(1,1,1,1, unit="cm"),
  		plot.title.position="plot",
  		plot.caption.position="plot",
  		plot.title = element_text(hjust=.5, face="bold", size=17),
  		plot.subtitle = element_text(hjust=.5, size=16),
  		plot.caption=element_text(size=14),
  		legend.text=element_text(size=15),
  		plot.background=element_rect(fill="white", color=NA)) +
  labs(fill="", title="Cobertura de energía eléctrica a nivel municipal", subtitle= "Porcentaje de cobertura de energía eléctrica en municipios de Bolivia 2016", caption="Porcentaje de hogares con cobertura de energía eléctrica.\n Feb 2022 | Datos de GeoBolivia / @mauforonda") +
  guides(fill=guide_colorbar(barwidth = unit(.5, "lines"),
                             barheight = unit(8, "lines")))

# 3d plot  		
render_snapshot(clear=TRUE)
plot_gg(p1,theta=-10, phi=70, multicore = TRUE, units = "cm", width=20, height=20, zoom=0.6)

# Guardar gráfico
dev.print(width=1000, height=1000, png, "bol_mun_cobelectrica_2016.png")
