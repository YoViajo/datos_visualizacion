## Ref: https://r-coder.com/dot-plot-r/
## DOT PLOT IN R

## LA FUNCIÓN DOTCHART

# Conjunto de datos que representa las ventas esperadas y reales
# para cada mes de una empresa
set.seed(1)

month <- month.name
expected <- c(15, 16, 20, 31, 11, 6,
              17, 22, 32, 12, 19, 20)
sold <- c(8, 18, 12, 10, 41, 2,
          19, 26, 14, 16, 9, 13)
quarter <- c(rep(1, 3), rep(2, 3), rep(3, 3), rep(4, 3))

data <- data.frame(month, expected, sold, quarter)
data

# Gráfico de punto de la variable "sold" (venta real)
dotchart(data$sold, labels = data$month, pch = 21, bg = "green", pt.cex = 1.5)

# GRÁFICO DE PUNTO POR GRUPO

# Groups
colors <- numeric(4)
colors[quarter == "1"] <- "red"
colors[quarter == "2"] <- "blue"
colors[quarter == "3"] <- "green"
colors[quarter == "4"] <- "orange"

dotchart(data$expected, labels = data$month, pch = 19,
         pt.cex = 1.5, groups = rev(data$quarter), color = colors)

# ORDENAR DOTCHART POR UNA VARIABLE

x <- data[order(data$expected), ] 

dotchart(x$expected, labels = x$month, pch = 19,
         xlim = range(x$expected, x$sold) + c(-2, 2),
         pt.cex = 1.5, color = colors, groups = rev(data$quarter))

# GRÁFICO DE PUNTO DUMBBELL
# Gráfico de punto con dos variables (gráficos dumbbell)

dotchart(data$sold, pch = 21, labels = data$month, bg = "green",
         pt.cex = 1.5, xlim = range(data$expected, data$sold) + c(-2, 2))
points(data$expected, 1:nrow(data), col = "red", pch = 19, cex = 1.5)

# Añadir segmentos y textos para etiquetar los puntos
dotchart(data$sold, labels = data$month, pch = 21, bg = "green",
         xlim = range(data$expected, data$sold) + c(-2, 2),
         pt.cex = 1.5)

points(data$expected, 1:nrow(data), col = "red", pch = 19, cex = 1.5)

invisible(sapply(1:nrow(data), function(i) {
  segments(min(data$sold[i], data$expected[i]), i,
           max(data$sold[i], data$expected[i]), i, lwd = 2)
  text(min(data$sold[i], data$expected[i]) - 1.5, i,
       labels = min(data$sold[i], data$expected[i]))
  text(max(data$sold[i], data$expected[i]) + 1.5, i,
       labels = max(data$sold[i], data$expected[i]))
}))

points(data$expected, 1:nrow(data), col = "red", pch = 19, cex = 1.5)
points(data$sold, 1:nrow(data), col = "red", pch = 21, bg = "green", cex = 1.5)

# FUNCIÓN DUMBBELL
# Trabaja con datos agrupados y no agrupados
# argumentos: añadir los segmentos, el texto, ambos o solo los puntos

# v1: numeric variable
# v2: numeric variable
# group: vector (numeric or character) or a factor containing groups
# labels: labels for the dot chart
# segments: whether to add segments (TRUE) or not (FALSE)
# text: whether to add text (TRUE) or not (FALSE)
# pch: symbol
# col1: color of the variable v1. If you want to
# add group colors add them here
# col1: color of the variable v2
# pt.cex: size of the points
# segcol: color of the segment
# lwd: width of the segment
# ... : additional arguments to be passed to dotchart function

dumbbell <- function(v1, v2, group = rep(1, length(v1)), labels = NULL,
                     segments = FALSE, text = FALSE, pch = 19,
                     colv1 = 1, colv2 = 1, pt.cex = 1, segcol = 1,
                     lwd = 1, ...) {
  
  o <- sort.list(as.numeric(group), decreasing = TRUE)
  group <- group[o]
  offset <- cumsum(c(0, diff(as.numeric(group)) != 0))
  y <- 1L:length(v1) + 2 * offset
  
  dotchart(v1, labels = labels, color = colv1, xlim = range(v1, v2) + c(-2, 2),
           groups = group, pch = pch, pt.cex = pt.cex)
  
  if(segments == TRUE) {
    for(i in 1:length(v1)) {
      segments(min(v2[i], v1[i]), y[i],
               max(v2[i], v1[i]), y[i],
               lwd = lwd, col = segcol) 
    }
  }
  
  for(i in 1:length(v1)){
    points(v2[i], y[i], pch = pch, cex = pt.cex, col = colv2)
    points(v1[i], y[i], pch = pch, cex = pt.cex, col = colv1)
  }
  
  if(text == TRUE) {
    for(i in 1:length(v1)) {
      text(min(v2[i ], v1[i]) - 1.5, y[i],
           labels = min(v2[i], v1[i]))
      text(max(v2[i], v1[i]) + 1.5, y[i],
           labels = max(v2[i], v1[i])) 
    }
  }
}

# Muestra la comparación entre ventas reales (azul) y ventas esperadas (negro) para cada mes
dumbbell(v1 = data$expected, v2 = data$sold, text = FALSE,
         labels = data$month, segments = TRUE, pch = 19,
         pt.cex = 1.5, colv1 = 1, colv2 = "blue")

# Dividir los datos en grupos y también agregar textos con cada valor
dumbbell(v1 = data$expected, v2 = data$sold, group = data$quarter,
         text = TRUE, labels = data$month, segments = TRUE, pch = 19,
         pt.cex = 1.5, colv1 = 1, colv2 = "blue")

# Si quiere agregar colores para cada grupo, puede usar el argumento colv1
dumbbell(v1 = data$expected, v2 = data$sold, group = data$quarter,
         text = TRUE, labels = data$month, segments = TRUE,
         pch = 19, pt.cex = 1.5, colv1 = colors)

# Puede ordenar los datos por alguna variables
# Los puntos negros son ordenados en orden creciente
x <- data[order(data$expected), ] 

dumbbell(v1 = x$expected, v2 = x$sold, group = data$quarter,
         text = TRUE, segcol = "gray", lwd = 3, labels = x$month,
         segments = TRUE, pch = 19, pt.cex = 1.5, colv1 = 1, colv2 = "blue")
