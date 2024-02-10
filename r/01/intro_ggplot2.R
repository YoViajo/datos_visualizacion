# Ref: https://ggplot2tutor.com/tutorials/beginner_tutorial
# A gentle introduction to some key concepts in ggplot2 for beginners


library(tidyverse)

celebs <- tibble(
  name = c("Brad Pitt", "Daniel Day-Lewis", 
           "Tom Hanks", "Natalie Portman", 
           "Kate Winslet", "Cate Blanchett"),
  age  = c(56, 62, 63, 38, 44, 50),
  oscars = c(0, 3, 2, 1, 1, 2),
  gender = c("male", "male", "male", 
             "female", "female", "female")
) %>% 
  mutate(oscars = as.factor(oscars))
celebs

ggplot()

aes(x = age, 
    y = oscars,
    color = oscars)

# Representación diagrama de dispersión
ggplot(data = celebs, mapping = aes(x = age, y = oscars)) +
  geom_point()

# Notación alternativa, sin las palabras "data" y "mapping"
ggplot(celebs, aes(x = age, y = oscars)) +
  geom_point()

# Misma estética, diferentes objetos geométricos
ggplot(celebs, aes(x = age, y = oscars)) +
  geom_text(label = "Some text")

# Prueba con otros tipos de geometría: rectángulos y líneas con un ángulo
ggplot(celebs, aes(x = age, y = oscars)) +
  geom_rect(aes(xmin = age, 
                xmax = age + 0.5,
                ymin = oscars, 
                ymax = as.integer(oscars) + 0.5))

ggplot(celebs, aes(x = age, y = oscars)) +
  geom_spoke(angle = .45, radius = 0.5)

# Puntos más grandes en el diagrama de dispersión
ggplot(celebs, aes(x = age, y = oscars)) +
  geom_point(size = 9)

# El color de los puntos es mapeado según el género de la estrella de cine
ggplot(celebs, aes(x = age, y = oscars, 
                   color = gender)) +
  geom_point(size = 9)

# Transparencia según el género
ggplot(celebs, aes(x = age, y = oscars, 
                   alpha = gender)) +
  geom_point(size = 9)

# Tamaño de puntos según el número de oscars ganados
ggplot(celebs, aes(x = age, y = oscars, 
                   size = oscars)) +
  geom_point()

# Se pueden aplicar diferentes estéticas de mapeo a un solo objeto geométrico
ggplot(celebs, aes(x = age, y = oscars,
                   color = gender,
                   size = oscars)) +
  geom_point()
  
# El mapeo de color estético se aplica a diferentes geometrías
ggplot(celebs, aes(x = age, y = oscars,
                   color = gender)) +
  geom_point(size = 9) +
  geom_text(label = "Some text", nudge_y = 0.3)

# Si se quiere controlar la estética de color para una geometría específica se agrega un "aes"
ggplot(celebs, aes(x = age, y = oscars)) +
  geom_point(size = 9, aes(color = gender)) +
  geom_text(label = "Some text", nudge_y = 0.3)

# Cambiar manualmente la apariencia de color, aplicando a cantidad de oscar 
ggplot(celebs, aes(x = age, y = oscars)) +
  geom_point(size = 7, aes(color = oscars)) +
  scale_color_manual(values = c("green", "blue", "red", "purple"))

# Aplicar paleta viridis, ya incluida
ggplot(celebs, aes(x = age, y = oscars)) +
  geom_point(aes(color = oscars), size = 7) +
  scale_color_viridis_d()

# Paleta gris
ggplot(celebs, aes(x = age, y = oscars)) +
  geom_point(aes(color = oscars), size = 7) +
  scale_color_grey(start = 0.1, end = 0.9)

glimpse(celebs)

# Cambiar de función de escala, para después aplicar cambios al eje x
ggplot(celebs, aes(x = age, y = oscars)) +
  geom_point(size = 7) +
  scale_x_continuous(name = "Celebs Age")

# Resaltar los cortes en el eje x
ggplot(celebs, aes(x = age, y = oscars)) +
  geom_point(size = 7) +
  scale_x_continuous(name = "Celebs Age",
                     breaks = c(40, 50, 60))

# Agregar texto en los cortes
ggplot(celebs, aes(x = age, y = oscars)) +
  geom_point(size = 7) +
  scale_x_continuous(name = "Celebs Age",
                     breaks = c(40, 50, 60),
                     labels = c("Forty", "Fifty", "Sixty"))

# Mover el eje x al tope
ggplot(celebs, aes(x = age, y = oscars)) +
  geom_point(size = 7) +
  scale_x_continuous(name = "Celebs Age",
                     position = "top")
