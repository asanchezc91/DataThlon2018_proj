library(shiny)

rm(list=ls(all=TRUE))

library('readxl')
library(data.table)
library(prophet)

main.path <- '~'
data.path <- 'datasets/'

datos <- data.table(read_xlsx(paste0(data.path, 'datos_dathaton.xlsx'), col_types = c(rep('guess',4), 'date', rep('guess',30))))


# countries = unique(datos$country)

# Define the UI
ui <- shinyUI(
  fluidPage(
    
    navbarPage('Call Of Data II',
               ########### tabPanel: Inf
               # tabPanel('General',
               # 
               #          # sidebarLayout(
               #          #
               #          #     ),
               # 
               #            # Show a plot of the generated distribution
               #            mainPanel(
               #              # imageOutput("myImage"),
               #              
               #            )
               #          ),

             
               
               tabPanel('Time Series',
                        
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("Sel_country",
                                        "Selecciona pais:",
                                        choices = countries,
                                        selected = c('sudan')
                            )
                          ),
                          
                          # Show a plot of the generated distribution
                          mainPanel(
                            plotOutput('plot')
                          )
                        )
                        
               )
                        
        ))
)


# Define the server code
server <- function(input, output) {
  output$plot <- renderPlot({
    country = input$Sel_country
    objetive = "AT_who_whz"
    data = datos[datos[['country']] == input$Sel_country]
    data[[objetive]] = as.numeric(data[[objetive]])
    data$survey_date = as.Date(data$survey_date)
    
    #aggregate by date
    d = aggregate(data[[objetive]], by=list(data$survey_date), mean, na.action = 'ignore')
    
    #rename and prophet
    colnames(d) = c('ds' , 'y')
    m <- prophet(d)
    
    future <- make_future_dataframe(m, periods = 365)
    forecast <- predict(m, future)
    
    plot(m, forecast)
  })
  output$myImage <- renderImage({
    # A temp file to save the output.
    # This file will be removed later by renderImage
    outfile <- tempfile(fileext = 'plot_terrenos.png')})
    
}

# Return a Shiny app object
shinyApp(ui = ui, server = server)




