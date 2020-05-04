shinyServer(function (input, output) {
  output$map <- renderLeaflet({
    pal <- colorBin("Spectral", flight_counts$count, n = 5)
    
    popup_data <- paste0("Airport: ",
                         flight_counts$Airport,
                         "<br>Count: ",
                         flight_counts$count)
    
    leaflet(flight_counts) %>%
      setView(lng = -97, lat = 38, zoom = 4) %>%
      addProviderTiles("CartoDB.Positron", options = providerTileOptions(noWrap = TRUE)) %>%
      addCircles(data = flight_counts,
                 lat = ~Latitude,
                 lng = ~Longitude,
                 weight = 1,
                 radius = ~count,
                 color = ~pal(count),
                 fillOpacity = 0.5,
                 popup = ~popup_data) %>%
      addLegend("bottomright", pal = pal, values = ~flight_counts$count,
                title = "Number of flights delays<br>(at ORIGIN airport)",
                labFormat = labelFormat(),
                opacity = 1)
  })
  
  output$mytable <- DT::renderDataTable({
    datatable(airport_delays)
  }, options = list(scrollX = TRUE))
  
  output$myplot <- renderPlot({
    airport_delays_sample <- airport_delays %>% sample_frac(0.1)
    cols <- brewer.pal(10, "Spectral")
    pal <- colorRampPalette(cols)
    
    stripplot(CARRIER ~ ARR_DELAY,
              data = airport_delays_sample,
              aspect = 1,
              jitter = T,
              xlab = "ARR_DELAY",
              ylab = "CARRIER",
              groups = airport_delays_sample$CARRIER,
              col = pal(20),
              pch = 19,
              cex = 1)
  })
})