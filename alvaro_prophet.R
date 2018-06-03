
rm(list=ls(all=TRUE))

library('readxl')
library(data.table)
library(prophet)

main.path <- '~'
data.path <- 'datasets/'

datos <- data.table(read_xlsx(paste0(data.path, 'datos_dathaton.xlsx'), col_types = c(rep('guess',4), 'date', rep('guess',30))))

#####################
# PROPHET FUNCTION
#####################

our_prophet = function(data, country,objetive){
  #Clean data
  data = data[data[['country']] == country]
  data[[objetive]] = as.numeric(data[[objetive]])
  data$survey_date = as.Date(data$survey_date)
  
  #aggregate by date
  d = aggregate(data[[objetive]], by=list(data$survey_date), mean, na.action = 'ignore')
  
  #rename and prophet
  colnames(d) = c('ds' , 'y')
  m <- prophet(d)
  
  future <- make_future_dataframe(m, periods = 365)
  forecast <- predict(m, future)
  
  #plot
  # plot(m, forecast)
  
  #prophet_plot_components(m, forecast)
  return(m,forecast)
}

data = datos
country = 'mali'
objetive = "AT_who_whz"
objetive = "AT_muac"

our_prophet(datos, country,objetive)


