rm(list = ls())
setwd('/home/cod4')
data.path <- 'datasets/'
require(data.table)
require(readxl)

# Datos
biomass <- data.table(read_xlsx('datasets/biomass_production_adm_2.xlsx')) 
datos <-  data.table(read_xlsx('datasets/datos_dathaton.xlsx', col_types = c(rep('guess', 4), 'date', rep('guess', 30))))
datos[, AT_muac := as.integer(AT_muac)]
health <- data.table(read_xlsx('datasets/HEALTH_DISTRICT_DATA.xlsx'))
infor <- data.table(read_xlsx('datasets/INFORM_Mid2018_v034.xlsx'))
niger <- data.table(read_xlsx('datasets/NIGER_BD_Surveillance_Pastorale_2015-2017.xlsx')) 
reasons <- data.table(read_xlsx('datasets/REASONS_FOR_NON_ATTENDANCE.xlsx')) 
weighted <- data.table(read_xlsx('datasets/WEIGHTED_BARRIERS.xlsx')) 

datasets <- c('biomass', 'datos', 'health', 'infor', 'niger', 'reasons', 'weighted')
for (n in datasets){
  setnames(get(n), names(get(n)), gsub(" ","_",names(get(n))))
}


# Datos hojas de infor:
sheet.names <- excel_sheets(paste0(data.path, 'INFORM_Mid2018_v034.xlsx'))
sheet.names <- gsub(' ', '_', sheet.names)

for (i in 3:length(sheet.names)){
  assign(paste0('inform_', sheet.names[i]), data.table(read_xlsx(paste0(data.path, 'INFORM_Mid2018_v034.xlsx'), sheet = i)))
}


# Países que intersecan health y biomass:
# "Burkina Faso" "Cameroon"     "Chad"         "Mali"         "Mauritania"   "Niger"       
# "Nigeria"      "Senegal" 
paises <- intersect(tolower(health$Country), tolower(biomass$CNTRY_NAME))
reg_health <- health[Country %in% paises]$HD_Code


paisesfinales <- unique(datos[country %in% paises]$country)
#  "mali"       "chad"       "niger"      "mauritania"

datos1 <- datos[country %in% paises]


###############################################
datos[, AT_wh := ifelse(AT_who_whz < -2, 1, 0)]
datos[, AT_ha := ifelse(AT_who_haz < -2, 1, 0)]
datos[, AT_mu := ifelse(AT_muac < 125, 1, 0)]
datos[AT_muac < 110, AT_mu := 2]
datos <- datos[! is.na(AT_mu)]
datos[, freq := .N, by = .(country)]

datos <- datos[, .(country, freq, AT_wh, AT_ha, AT_mu)]
sd.cols <- c('AT_wh', 'AT_ha', 'AT_mu')
final <- datos[, lapply(.SD, sum), by = .(country), .SDcols = sd.cols]
pob <- unique(datos[, .(country, freq)])
final <- merge(final, pob, by = 'country')
final <- final[, AT_wh := 100*(AT_wh / freq)]
final <- final[, AT_ha := 100*(AT_ha / freq)]
final <- final[, AT_mu := 100*(AT_mu / freq)]

final[, freq := NULL]

write.csv(final, 'porcentajes_desnutridos_por_paises.csv', row.names = FALSE)


# Códigos países
intersect(health$HD_Code, biomass$CNTRY_CODE)




