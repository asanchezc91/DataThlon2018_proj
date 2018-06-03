rm(list=ls())

biomass <- read_xlsx("biomass_production_adm_2.xlsx") %>% data.table()
datos <-  read_xlsx("datos_dathaton.xlsx") %>% data.table()
health <- read_xlsx("HEALTH_DISTRICT_DATA.xlsx") %>% data.table()
inform <- read_xlsx("") %>% data.table()
niger <- read_xlsx("NIGER_BD_Surveillance_Pastorale_2015-2017.xlsx") %>% data.table()
reasons <- read_xlsx("REASONS_FOR_NON_ATTENDANCE.xlsx") %>% data.table()
weighted <- read_xlsx("WEIGHTED_BARRIERS.xlsx") %>% data.table()
