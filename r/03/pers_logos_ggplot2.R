## https://www.markhw.com/blog/logos
## HOW I PUT LOGOS ON GGPLOT2 FIGURES

library(tidyverse)
data("starwars")

(species <- starwars %>% 
    count(species) %>% 
    filter(!is.na(species) & n > 1) %>% 
    arrange(-n) %>% 
    mutate(species = factor(species, species)))

# Graficar el conteo
(p1 <- ggplot(species, aes(x = species, y = n)) +
    geom_bar(stat = "identity") +
    theme_light())
p1

# Cargar logo a partir de archivo PNG
get_png <- function(filename) {
  grid::rasterGrob(png::readPNG(filename), interpolate = TRUE)
}

l <- get_png("logo heuris.png")

t <- grid::roundrectGrob()

# Explorar área donde ubicar el logo
p1 +
  annotation_custom(t, xmin = 6.5, xmax = 8.5, ymin = -5, ymax = -8.5) +
  coord_cartesian(clip = "off") +
  theme(plot.margin = unit(c(1, 1, 3, 1), "lines"))


# Colocar mi logo
p1 +
  annotation_custom(l, xmin = 6.5, xmax = 10.2, ymin = -5, ymax = -10.7) +
  coord_cartesian(clip = "off") +
  theme(plot.margin = unit(c(1, 1, 3, 1), "lines"))
