## Ref: https://www.datasciencemadesimple.com/dot-plot-in-r/
## Dot plot in R (Dot Chart)

install.packages("datasets")

data("PlantGrowth")

# EXAMPLE OF DOT PLOT

#simple dot plot in R
dotchart(PlantGrowth$weight,col="red",pch=1,labels=PlantGrowth$group, main="group vs weight", xlab="weight")

# DOT PLOT FOR GROUPS
#Dot chart in R for groups
#subset and assign colour

pg <- PlantGrowth
pg$color[pg$group=="ctrl"] <- "red"
pg$color[pg$group=="trt1"] <- "Violet"
pg$color[pg$group=="trt2"] <- "blue"

# plot the dot chart
dotchart(PlantGrowth$weight, labels=PlantGrowth$group,cex=0.8,groups= PlantGrowth$group,
         main="group vs weight",
         xlab="weight", gcolor="black", color=pg$color)
