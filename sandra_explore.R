rm(list=ls(all=TRUE))

library('readxl')
library(data.table)

main.path <- '~'
data.path <- 'datasets/'

biomass <- data.table(read_xlsx(paste0(data.path, 'biomass_production_adm_2.xlsx')))
datos <- data.table(read_xlsx(paste0(data.path, 'datos_dathaton.xlsx')))
health <- data.table(read_xlsx(paste0(data.path, 'HEALTH_DISTRICT_DATA.xlsx')))
inform <- data.table(read_xlsx(paste0(data.path, 'INFORM_Mid2018_v034.xlsx')))
niger <- data.table(read_xlsx(paste0(data.path, 'NIGER_BD_Surveillance_Pastorale_2015-2017.xlsx')))
reasons <- data.table(read_xlsx(paste0(data.path, 'REASONS_FOR_NON_ATTENDANCE.xlsx')))
weighted <- data.table(read_xlsx(paste0(data.path, 'WEIGHTED_BARRIERS.xlsx')))



#coords

health
