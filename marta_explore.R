rm(list = ls())
setwd('/home/cod4')

require(data.table)
require(readxl)

# Datos
biomass <- data.table(read_xlsx('datasets/biomass_production_adm_2.xlsx')) 
datos <-  data.table(read_xlsx('datasets/datos_dathaton.xlsx'))
health <- data.table(read_xlsx('datasets/HEALTH_DISTRICT_DATA.xlsx'))
infor <- data.table(read_xlsx('datasets/INFORM_Mid2018_v034.xlsx'))
niger <- data.table(read_xlsx('datasets/NIGER_BD_Surveillance_Pastorale_2015-2017.xlsx')) 
reasons <- data.table(read_xlsx('datasets/REASONS_FOR_NON_ATTENDANCE.xlsx')) 
weighted <- data.table(read_xlsx('datasets/WEIGHTED_BARRIERS.xlsx')) 

