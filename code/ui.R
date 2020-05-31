shinyUI(
  fluidPage(theme = shinytheme("united"),
    fluidRow(column(4,
                    align="center",
                    HTML("<b><h2>Flight Delay Data Visualizations</h2></b>"),
                    HTML('<p align="justify" style="padding-left: 100px; padding-right: 100px">
                    The below visualizations are obtained using the airline data from the US
                    Bureau of Transportation Statistics for the year 2018 and 2019 Q1, Q2.
                    This shows stripplot between CARRIER and ARRIVAL DELAY. Then, there is a
                    map which shows the number of flight delays at the ORIGIN airport. Also,
                    this includes the dataframe enabling search.</p>'),
                    br(),
                    br(),
                    selectInput('Year', 'Year',
                                choices = years,
                                multiple = FALSE,
                                selected = 'ALL'),
                    selectInput('Quarter', 'Quarter',
                                choices = quarters,
                                multiple = FALSE,
                                selected = 'ALL'),
                    selectInput('Carrier', 'Carrier',
                                choices = carriers,
                                multiple = FALSE,
                                selected = 'ALL'),
                    dateRangeInput('daterangeInput',
                                   label = 'Date',
                                   start = as.Date('2018-01-01') , end = as.Date('2019-06-27')
                    ),
                    br(),
                    plotOutput("myplot")
    ),
    
    column(8,
           br(),
           leafletOutput(outputId = 'map', height = 400, width = 1200),
           br(),
           DT::dataTableOutput('mytable'))
    )
  )
)