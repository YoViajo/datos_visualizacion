## TORRES DE CELULAR EN BOLIVIA

## Basado en script: https://github.com/rafalopespx/cell_towers_br

library(dplyr)

library(readr)
library(ggplot2)
library(ggtext)
library(sf)


library(rnaturalearth)
library(rnaturalearthdata)
#library(geobr)

# Filtrado del conjunto de datos Torres de Celular

## Setting the CRS for the celltowers dataset
celltowers <- read_csv("dat/736.csv.gz")|> 
  sf::st_as_sf(coords = c("lon", "lat"), crs = 4326)


## Obtener la extensión de Bolivia
bolivia <- ne_countries(scale = 'medium', type = 'map_units', returnclass = 'sf') |>  filter(name == 'Bolivia')
#bolivia <- ne_countries(country = 'Bolivia', scale = 'medium', type = 'map_units', returnclass = 'sf')

## Filtering towers by type
### 3G
UMTS <- celltowers |> 
  filter(radio == "UMTS") |>
  st_intersection(bolivia)

### 4G
LTE <- celltowers |> 
  filter(radio == "LTE") |>
  st_intersection(bolivia)

### Gráficos

## A Quick plot of the extent
ggplot() + 
  geom_sf(data = bolivia)

## A plot of celltowers on the map
ggplot() + 
  geom_sf(data = bolivia, fill = "black", color = "white", size = 0.3) + 
  geom_sf(data = UMTS, shape = ".", color = "#4d88ff", alpha = 0.3) +
  geom_sf(data = LTE, shape = ".", color = "#cc0000", alpha = 0.5)

## Saving the plot
ggsave("my_plot_bo.png", height = 7, width = 7) 
