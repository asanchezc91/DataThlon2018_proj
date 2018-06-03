rm(list=ls(all=TRUE))

library('readxl')
library(data.table)

main.path <- '~'
data.path <- 'datasets/'

biomass <- data.table(read_xlsx(paste0(data.path, 'biomass_production_adm_2.xlsx')))
datos <- data.table(read_xlsx(paste0(data.path, 'datos_dathaton.xlsx'), col_types = c(rep('guess',4), 'date', rep('guess',30))))
health <- data.table(read_xlsx(paste0(data.path, 'HEALTH_DISTRICT_DATA.xlsx')))

#inform tiene sólo algunas hojas que nos interesan:

sheet.names <- excel_sheets(paste0(data.path, 'INFORM_Mid2018_v034.xlsx'))
sheet.names <- gsub(' ', '_', sheet.names)

for (i in 3:length(sheet.names)){
  assign(paste0('inform_', sheet.names[i]), data.table(read_xlsx(paste0(data.path, 'INFORM_Mid2018_v034.xlsx'), sheet = i)))
}

niger <- data.table(read_xlsx(paste0(data.path, 'NIGER_BD_Surveillance_Pastorale_2015-2017.xlsx')))
reasons <- data.table(read_xlsx(paste0(data.path, 'REASONS_FOR_NON_ATTENDANCE.xlsx')))
weighted <- data.table(read_xlsx(paste0(data.path, 'WEIGHTED_BARRIERS.xlsx')))

datasets <- c('biomass', 'datos', 'health', 'niger', 'reasons', 'weighted')

for (n in datasets){
  setnames(get(n), names(get(n)), gsub(" ","_",names(get(n))))
}


dtb <-`inform_INFORM_Mid2018_(a-z)`
dtb <- dtb[2:nrow(dtb),2:8, with=FALSE]
dtb <- dtb[ISO3 %in% unique(datos$iso_country)]
dtb <- melt(dtb, id = 'ISO3', measure.vars = setdiff(names(dtb), 'ISO3'))

health[, HD_Code:= substr(HD_Code, 1, 3)]

merge(dtb, health, by.x='ISO3', by.y = 'HD_Code', all.x=TRUE)

#Data Merging

# Health y datos

prueba<- merge(biomass, health, by.x = 'ADM1_NAME', by.y = 'Health_District', all.x=TRUE)


#Cluster_Medoids