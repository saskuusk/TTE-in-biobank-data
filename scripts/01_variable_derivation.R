```r
#install.packages("mice")
library(mice)
library(data.table)
library(dplyr)

# loading separate datasets for all events (1-3)
load("data_I-2025v03.RData") # load data_I ...
load("data_II-2025v03.RData")
load("data_III-2025v03.RData")

setkey(data_I, Person.skood, interDate)
setkey(data_II, Person.skood, interDate)
setkey(data_III, Person.skood, interDate)

# find the time difference between trial start and plasma sample date
data_I[, time_diff := as.numeric(difftime(interDate, sample_date, units = "days"))]
data_II[, time_diff := as.numeric(difftime(interDate, sample_date, units = "days"))]
data_III[, time_diff := as.numeric(difftime(interDate, sample_date, units = "days"))]

data_I[, time_diff_abs := abs(time_diff)]
data_II[, time_diff_abs := abs(time_diff)]
data_III[, time_diff_abs := abs(time_diff)]

setorder(data_I, Person.skood, interDate, time_diff_abs)
setorder(data_II, Person.skood, interDate, time_diff_abs)
setorder(data_III, Person.skood, interDate, time_diff_abs)

# there are more than one plasma samples for some, choose the first
data_I <- data_I[, .SD[1], by = .(Person.skood, interDate)]
data_II <- data_II[, .SD[1], by = .(Person.skood, interDate)]
data_III <- data_III[, .SD[1], by = .(Person.skood, interDate)]

data_I[, time_diff_abs := NULL] ; data_II[, time_diff_abs := NULL] ; data_III[, time_diff_abs := NULL]

# start with imputating missing LDL-c values (using a subset of data)
data_I_imputation <- data_I[, .(interLDL, interTotal, gender.name, measurementAge, diabetes, smokingStatus, valueBMI, valueSBP, medicationUse, educationGroup.name, hypertension, CVDHistory, nr_visits, VLDL_C, Clinical_LDL_C, HDL_C, time_diff)]
data_I_imputation[, `:=`(gender.name = as.factor(gender.name),
                         diabetes = as.logical(diabetes),
                         smokingStatus = as.factor(smokingStatus),
                         medicationUse = as.logical(medicationUse),
                         educationGroup.name = as.factor(educationGroup.name),
                         hypertension = as.logical(hypertension),
                         CVDHistory = as.logical(CVDHistory))]

pred_matrix <- make.predictorMatrix(data_I_imputation)
where_matrix <- matrix(FALSE, nrow = nrow(data_I_imputation), ncol = ncol(data_I_imputation))
colnames(where_matrix) <- names(data_I_imputation)
where_matrix[, "interLDL"] <- is.na(data_I_imputation$interLDL)
imputed_data <- mice(data_I_imputation, predictorMatrix = pred_matrix, maxit = 50, seed = 500, method = "pmm", where = where_matrix)

# Imputation investigation
hist(complete(imputed_data)[,1])
summary(complete(imputed_data)[,1])
complete(imputed_data) %>% filter(is.na(interLDL) & (is.na(Clinical_LDL_C) | is.na(smokingStatus) | is.na(valueBMI) | is.na(valueSBP) | is.na(educationGroup.name))) %>% nrow()
# those who have a missing covariate and LDL-c value don't get imputed
summary(imputed_data)
plot(imputed_data)

# same process for data_II (major cardiovascular event) and data_II (cardiovascular mortality event)
data_II_imputation <- data_II[, .(interLDL, interTotal, gender.name, measurementAge, diabetes, smokingStatus, valueBMI, valueSBP, medicationUse, educationGroup.name, hypertension, CVDHistory, nr_visits, VLDL_C, Clinical_LDL_C, HDL_C, time_diff)] 
data_II_imputation[, `:=`(gender.name = as.factor(gender.name),
                         diabetes = as.logical(diabetes),
                         smokingStatus = as.factor(smokingStatus),
                         medicationUse = as.logical(medicationUse),
                         educationGroup.name = as.factor(educationGroup.name),
                         hypertension = as.logical(hypertension),
                         CVDHistory = as.logical(CVDHistory))]

pred_matrix <- make.predictorMatrix(data_II_imputation)
where_matrix <- matrix(FALSE, nrow = nrow(data_II_imputation), ncol = ncol(data_II_imputation))
colnames(where_matrix) <- names(data_II_imputation)
where_matrix[, "interLDL"] <- is.na(data_II_imputation$interLDL)
imputed_data2 <- mice(data_II_imputation, predictorMatrix = pred_matrix, maxit = 50, seed = 500, method = "pmm", where = where_matrix)

# Imputation investigation
hist(complete(imputed_data2)[,1])
summary(complete(imputed_data2)[,1])
complete(imputed_data2) %>% filter(is.na(interLDL)& (is.na(Clinical_LDL_C) | is.na(smokingStatus) | is.na(valueBMI) | is.na(valueSBP) | is.na(educationGroup.name))) %>% nrow()
# those who have a missing covariate and LDL-c value don't get imputed
summary(imputed_data2)
plot(imputed_data2)

data_III_imputation <- data_III[, .(interLDL, interTotal, gender.name, measurementAge, diabetes, smokingStatus, valueBMI, valueSBP, medicationUse, educationGroup.name, hypertension, CVDHistory, nr_visits, VLDL_C,Clinical_LDL_C, HDL_C, time_diff)] 
data_III_imputation[, `:=`(gender.name = as.factor(gender.name),
                          diabetes = as.logical(diabetes),
                          smokingStatus = as.factor(smokingStatus),
                          medicationUse = as.logical(medicationUse),
                          educationGroup.name = as.factor(educationGroup.name),
                          hypertension = as.logical(hypertension),
                          CVDHistory = as.logical(CVDHistory))]

pred_matrix <- make.predictorMatrix(data_III_imputation)
where_matrix <- matrix(FALSE, nrow = nrow(data_III_imputation), ncol = ncol(data_III_imputation))
colnames(where_matrix) <- names(data_III_imputation)
where_matrix[, "interLDL"] <- is.na(data_III_imputation$interLDL)
imputed_data3 <- mice(data_III_imputation, predictorMatrix = pred_matrix, maxit = 50, seed = 500, method = "pmm", where = where_matrix)

# Imputation investigation
hist(complete(imputed_data3)[,1])
summary(complete(imputed_data3)[,1])
complete(imputed_data3) %>% filter(is.na(interLDL) & (is.na(Clinical_LDL_C) | is.na(smokingStatus) | is.na(valueBMI) | is.na(valueSBP) | is.na(educationGroup.name))) %>% nrow()
# those who have a missing covariate and LDL-c value don't get imputed
summary(imputed_data3)
plot(imputed_data3)

data_I[, imputedLDL := complete(imputed_data)[,1]]
data_II[, imputedLDL := complete(imputed_data2)[,1]]
data_III[, imputedLDL := complete(imputed_data3)[,1]]
rm(data_I_imputation, data_II_imputation, data_III_imputation, imputed_data, imputed_data2, imputed_data3, pred_matrix, where_matrix)
rm(nmr_normalized_final)

save(data_I, file ="data_I-2025v03.RData")
save(data_II, file ="data_II-2025v03.RData")
save(data_III, file = "data_III-2025v03.RData")
