% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/streetDist.R
\name{streetDist}
\alias{streetDist}
\title{Distribution by OpenStreetnMap street}
\usage{
streetDist(emission = NULL, dist = NULL, grid = NULL, osm = NULL,
  epsg = NULL)
}
\arguments{
\item{emission}{numeric of emissions}

\item{dist}{numeric vector with length 5. The order represents motorway,
trunk, primary, secondary and tertiary}

\item{grid}{grid of polygons class sf}

\item{osm}{streets of OpenStreetMaps class sf}

\item{epsg}{spatial code for projecting spatial data}
}
\value{
grid of polygon
}
\description{
Distribute emissions by streets of OpenStreetMap
}
\examples{
\dontrun{
# Do not run
library(sf)
# Download OSM streets
streets <- st_read("path")
streets <- streets[streets$highway != "residential", ]
# Grid
grid  <- gridInfo(paste(system.file("extdata", package = "EmissV"),"/wrfinput_d02",sep=""))
names(grid)
d3 <- data.frame(x = as.numeric(grid$Lon),
                 y = as.numeric(grid$Lat))
d3 <- st_as_sf(d3, coords = c("x","y"))
st_crs(d3) <- st_crs(4326)
library(vein)
g <- st_transform(st_as_sf(vein::make_grid(as(st_transform(d3, 31983),
                  "Spatial"),
               grid$DX*1000, grid$DX*1000, T)), 4326)
streets$id <- NULL
per <- c(1, 0, 0, 0, 0)
teste <- streetDist(emission = 1000000, dist = per, grid = g,
                    osm = streets, epsg = 31983)
}
}
\author{
Sergio Ibarra
}