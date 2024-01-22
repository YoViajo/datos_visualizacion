## Treemap: Bolivia, exportaciones tradicionales y no tradicionales 2021(p)

## basado en:
## Ref: https://www.r-graph-gallery.com/235-treemap-with-subgroups.html
## Treemap with subgroups


# library
library(treemap)

# Definir conjunto de datos (fuente: INE)
grupo <- c(rep("No Tradicionales", 12), rep("Tradicionales", 10))
subgrupo <- c("Algodón","Azúcar","Bebidas","Cacao","Café","Castaña","Cueros","Joyería","Joyería Con Oro Imp.","Maderas","Otros Productos","Soya","Antimonio","Estaño","Gas Natural","Oro","Otros Hidrocarburos","Otros Minerales","Plata","Plomo","Wólfram","Zinc")
valor <- c(0.2778063,60.34878986,58.5362408,2.25807748,10.17080137,157.25432789,27.87482969,203.92526196,0.59106748,84.81286187,742.40816388,1368.58973068,30.92122552,567.7493559,2249.07709276,2557.64155301,110.5462315,	123.04118971,1018.9806218,197.67204994,31.27133143,1381.61104248)
datos <- data.frame(grupo,subgrupo,valor)

# treemap
treemap(datos,
        index=c("grupo","subgrupo"),
        vSize="valor",
        type="index"
)
