# Clear plots
if(!is.null(dev.list())) dev.off()
# Clear console
cat("\014") 
# Clean workspace
rm(list=ls())

## Mapa de una ciudad basado en datos OSM 
## Adaptado para la ciudad de Santa Cruz, SC, Bolivia

## Inspirado en:
# Ref: https://github.com/tashapiro/30DayMapChallenge/blob/main/basel-openstreetmap/basel_map.R

library(tidyverse)
library(osmdata)
library(sf)
library(extrafont)
library(sysfonts)
library(pdp)

# Caja límite de la ciudad de Santa Cruz, Bolivia (formato: c(xmin, ymin, xmax, ymax))
scz_lim <- c(-63.190185628293,-17.7926357985537,-63.170910207938,-17.7746919062687)

streets <- scz_lim%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", 
                            "secondary", "tertiary")) %>%
  osmdata_sf()
streets

small_streets <- scz_lim%>%
  opq()%>%
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            "unclassified",
                            "service", "footway")) %>%
  osmdata_sf()


river <- scz_lim%>%
  opq()%>%
  add_osm_feature(key = "waterway", value = "river") %>%
  osmdata_sf()


background_color<-'#1E212B'
street_color<-'#FAD399'
small_street_color<-'#D4B483'
river_color<-'#0ACDFF'
font_color<-'#FFFFFF'

font_add("Courier New")
font_add("Optimus Princeps", "/Library/Fonts/OptimusPrinceps.ttf")
chart_font<-"Optimus Princeps"
scz_dark<-ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = street_color,
          size = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = small_street_color,
          size = .2,
          alpha = .6) +
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE,
          color = river_color,
          size = .2,
          alpha = .5) +
  coord_sf(xlim = c(-63.190185628293, -63.170910207938), 
           ylim = c(-17.7926357985537, -17.7746919062687),
           expand = FALSE) +
  theme_void() +
  theme(plot.title = element_text(family=chart_font,
                                  color=font_color,
                                  size = 18, face="bold", hjust=.5,
                                  vjust=2.5),
        panel.border = element_rect(colour = "white", fill=NA, size=3),
        plot.margin=unit(c(0.6,1.6,1,1.6),"cm"),
        plot.subtitle = element_text(color=font_color,
                                     family=chart_font,
                                     vjust=2.5,
                                     size = 12, hjust=.5, margin=margin(2, 0, 5, 0)),
        plot.background = element_rect(fill = "#282828")) +
  labs(title = "SANTA CRUZ, BOLIVIA", subtitle = "17.783°S | 63.180°W")


ggsave("scz_map_dark.jpeg", width=8, height=9)

background_color2<-'#faf9ed'
street_color2<-'#13130c'
small_street_color2<-'#37261a'
river_color2<-'#5985ab'
font_color2<-'#13130c'

scz_light<-ggplot() +
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE,
          color = river_color2,
          alpha=.5,
          size = .4) +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = street_color2,
          size = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = small_street_color2,
          size = .2,
          alpha = .6) +
  coord_sf(xlim = c(-63.190185628293, -63.170910207938), 
           ylim = c(-17.7926357985537, -17.7746919062687),
           expand = FALSE) +
  theme_void() +
  theme(plot.title = element_text(family=chart_font,
                                  color=font_color2,
                                  size = 18, face="bold", hjust=.5,
                                  vjust=2.5),
        panel.border = element_rect(colour = font_color2, fill=NA, size=3),
        plot.margin=unit(c(0.6,1.6,1,1.6),"cm"),
        plot.subtitle = element_text(color=font_color2,
                                     family=chart_font,
                                     vjust=2.5,
                                     size = 12, hjust=.5, margin=margin(2, 0, 5, 0)),
        plot.background = element_rect(fill = background_color2)) +
  labs(title = "SANTA CRUZ, BOLIVIA", subtitle = "17.783°S | 63.180°W")

scz_light

ggsave("scz_map_light.jpeg", width=8, height=9)

grid.arrange(scz_dark,scz_light, nrow=1)
