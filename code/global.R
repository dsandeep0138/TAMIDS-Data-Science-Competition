library(leaflet)
library(shiny)
library(shinythemes)
library(DT)
library(lattice)
library(RColorBrewer)
library(dplyr)

airports <- read.csv("Airports.csv")

latlong <- read.csv("airports.dat.txt", header=FALSE)
colnames(latlong) <- c('index',
                       'Name',
                       'city',
                       'country',
                       'Airport',
                       'Code',
                       'Latitude',
                       'Longitude',
                       'Altitude',
                       'TimeZone',
                       'DST',
                       'TZ',
                       'Type',
                       'Source')
latlong <- subset(latlong, select = -c(index))

airports <- merge(x = airports,
                  y = latlong,
                  by = "Airport")

airport_delays <- read.csv('../FlightDelays.csv')

flight_counts <- as.data.frame(sort(table(airport_delays$ORIGIN), decreasing = TRUE))
colnames(flight_counts) <- c('Airport', 'count')
flight_counts <- merge(x = airports,
                       y = flight_counts,
                       by = "Airport")[, c('Airport', 'Latitude', 'Longitude', 'count')]

rm(list = c("airport_delays"))

airport_delays <- read.csv('../flight_delays_clean.csv')
years <- append(as.list(unique(airport_delays$YEAR)), c('ALL'))
quarters <- append(as.list(unique(airport_delays$QUARTER)), c('ALL'))
carriers <- append(as.list(levels(unique(airport_delays$CARRIER))), c('ALL'))

airport_delays <- airport_delays[, c('FL_DATE', 'CARRIER', 'ORIGIN', 'DEST', 'Route', 'ARR_TIME', 'ARR_DELAY')]