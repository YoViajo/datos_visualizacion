for %f in (*.geojson) do ogr2ogr -f "GPKG" %~nf.gpkg %f
