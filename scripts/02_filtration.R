library(lubridate)
library(dplyr)
library(stringr)
library(tidyr)
library(data.table)

# loading dataset for composite cardiovaascular outcome event
# other event datasets filtration is based on this
load("data_I-2025v03.RData") 
# data_I is loaded to the environment

# ineligible calendar year
data_I[interDate<as.Date("2010-01-01")|interDate>as.Date("2019-12-31"), .N] # 3642028
data_I <- data_I[interDate>=as.Date("2010-01-01")&interDate<=as.Date("2019-12-31")]

# not CVD free at baseline
data_I[!is.na(diagnosisDate) & interDate>=diagnosisDate, .N] # 270306
data_I <- data_I[is.na(diagnosisDate) | interDate<diagnosisDate]

# prior use of statin therapy
data_I[!is.na(prescribedDate.) & interDate>prescribedDate., .N] # 72841 

# ALTERNATIVE: sensitivity analysis of implementing a 2-year statin wash-out period
# data_I[!is.na(prescribedDate_latest) & years_from_last_presc <= 2, .N] 
# data_I <- data_I[is.na(prescribedDate_latest) | years_from_last_presc > 2] # never had a prescription or the latest prescription was >2 years ago

# cholesterol not high enough to warrant cholesterol-lowering therapy
data_I[fifelse(!is.na(interLDL), interLDL < 4, interTotal < 6.5), .N] # 2999663
data_I <- data_I[(!is.na(interLDL) & interLDL >= 4) | (is.na(interLDL) & interTotal >= 6.5)]

# age >85 or <40
data_I[measurementAge <40 | measurementAge > 85, .N] # 109013
data_I <- data_I[measurementAge >= 40 & measurementAge<= 85]

# history of major chronic illness 
data_I[chronicIllnessHistory == 1, .N] # 65005
data_I <- data_I[chronicIllnessHistory == 0]

# people with any missing covriate values are also removed in modelling stage
